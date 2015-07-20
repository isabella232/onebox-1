module Onebox
  module Engine
    class IkeaOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.ikea\.com\/us\/en\//)

      def keywords
        raw.xpath('/html/head/meta[@name="keywords"]/@content').first.value
      end

      def image
        og_raw.images && og_raw.images.first
      end

      def description
        og_raw.description.gsub(/IKEA - #{Regexp.quote(keywords)}, /, "") if og_raw.description
      end

      def type
        og_raw.type
      end

      def price
        amount = raw.xpath('/html/head/meta[@name="price"]/@content')
        amount.any? && Monetize.parse(amount).cents.to_s
      end

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: keywords,
          image: image,
          description: description,
          type: type,
          price_cents: price
        }
      end
    end
  end
end
