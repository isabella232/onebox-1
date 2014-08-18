module Onebox
  module Engine
    class AllmodernOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.allmodern\.com\//)

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
          price_cents: Monetize.parse(raw.xpath("/html/head").xpath('//meta[@property="og:price:amount"]/@content').first.value).cents
        }
      end
    end
  end
end
