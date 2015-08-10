module Onebox
  module Engine
    class WestElmOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.westelm\.com\//)

      def title
        og_raw.title if og_raw.title
      end

      def price
        amount = raw.css('.pip-summary .product-price').text
        amount.empty? ? nil : Onebox::Helpers.squish(amount)
      end

      def price_cents
        Monetize.parse(price).cents.to_s
      end

      def image
        og_raw.images.first if og_raw.images && og_raw.images.first
      end

      def description
        return og_raw.description if og_raw.description
        raw_description = raw.css('.pip-summary .accordion-tab-copy').inner_html
        tag_break_index = raw_description.index("<p>")
        Onebox::Helpers.squish(raw_description[0...tag_break_index || -1])
      end

      def type
        og_raw.type
      end

      def data
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
