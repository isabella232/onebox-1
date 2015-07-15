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
        return og_raw.images.first if og_raw.images && og_raw.images.first
      end

      def description
        return og_raw.description.gsub(/IKEA - #{Regexp.quote(keywords)}, /, "") if og_raw.description
      end

      def type
        return og_raw.type if og_raw.type
      end

      def price
        Monetize.parse(raw.xpath('/html/head/meta[@name="price"]/@content').first.value).cents.to_s
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
