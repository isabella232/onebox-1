module Onebox
  module Engine
    class CB2Onebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.cb2\.com\//)

      def price
        price_element = raw.css('#_productWrap span.regPrice')[0]
        price_element ? price_element.text : nil
      end

      def price_cents
        return if price.include? '-'
        Monetize.parse(price).cents.to_s
      end

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: og_raw.title,
          image: (og_raw.images.first if og_raw.images && og_raw.images.first),
          description: og_raw.description,
          type: (og_raw.type if og_raw.type),
          price: price,
          price_cents: price_cents
        }
      end
    end
  end
end
