module Onebox
  module Engine
    class WayfairOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.wayfair\.com\//)

      def title
        return og_raw.title if og_raw.title
        raw.css('.title_name').inner_html.gsub(/<[^>]+>|\n|\s{2,}/, '')
      end

      def price
        amount = raw.css('.dynamic_sku_price').text
        amount.empty? ? nil : Onebox::Helpers.squish(amount)
      end

      def price_cents
        Monetize.parse(price).cents.to_s
      end

      def image
        return og_raw.images.first if og_raw.images && og_raw.images.first
        images = raw.css('[data-large-src]')
        images.first && images.first.attributes['data-large-src'].value
      end

      def description
        return og_raw.description if og_raw.description
        Onebox::Helpers.squish(raw.css('.no_json_description').inner_text)
      end

      def type
        og_raw.type
      end

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: title,
          image: image,
          description: description,
          type: type,
          price: price,
          price_cents: price_cents
        }
      end
    end
  end
end
