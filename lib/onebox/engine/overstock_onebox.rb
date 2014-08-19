module Onebox
  module Engine
    class OverstockOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^https:\/\/(?:www)\.overstock\.com\//)

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: og_raw.title,
          image: (og_raw.images.first if og_raw.images && og_raw.images.first),
          description: raw.xpath("/html/head").xpath('//meta[@name="description"]/@content').first.value.gsub(/\u0099/, ""),
          type: (og_raw.type if og_raw.type),
          price_cents: Monetize.parse(raw.xpath('//span[@itemprop="price"]').children).cents.to_s
        }
      end
    end
  end
end
