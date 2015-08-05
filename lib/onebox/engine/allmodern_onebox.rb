require 'htmlentities'

module Onebox
  module Engine
    class AllmodernOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.allmodern\.com\/(?!deals-and-design-ideas)/)

      def title
        title_element = raw.css('.title_name')[0]
        return unless title_element
        Onebox::Helpers.squish(title_element.text)
      end

      def image
        return og_raw.images.first if og_raw.images.any?
        img = raw.css('.mainpdimg img').first
        img ? img['src'] : nil
      end

      def description
        description_element = raw.css('.product_section_description')[0]
        return unless description_element
        Onebox::Helpers.squish(description_element.text)
      end

      def type
        og_raw.type
      end

      def price
        price_element = raw.css('.product_price')[0]
        return unless price_element
        Onebox::Helpers.squish(price_element.text)
      end

      def price_cents
        price.to_s.empty? ? nil : Monetize.parse(price).cents.to_s
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
          price_cents: price_cents,
          price: price
        }
      end
    end
  end
end
