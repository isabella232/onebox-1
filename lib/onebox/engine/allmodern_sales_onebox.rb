require 'htmlentities'

module Onebox
  module Engine
    class AllmodernSalesOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.allmodern\.com\/deals-and-design-ideas\/p\//)

      def title
        title_element = raw.css('.prodnameshare h1')[0]
        title_element ? Onebox::Helpers.squish(title_element.text) : nil
      end

      def image
        return og_raw.images.first if og_raw.images.any?
        img = raw.css('img.product_main_img').first
        img ? img['src'] : nil
      end

      def description
        return unless raw.css(".pdp_romance_copy").any?

        HTMLEntities.new.decode(raw.css(".pdp_romance_copy")[0].inner_html).
          gsub(/<[^>]+>|\s{2,}/,' ').
          gsub(/^\s+|\s+$/,'')
      end

      def type
        og_raw.type
      end

      def price
        price_element = raw.css('#sale_price')[0]
        Onebox::Helpers.squish(price_element.text) if price_element
      end

      def price_cents
        price.to_s.empty? ? nil : Monetize.parse(price).cents.to_s
      end

      def data
        {
          link: link,
          title: title,
          image: image,
          description: description,
          type: type,
          price_cents: price_cents,
          price: price
        }
      end
    end
  end
end
