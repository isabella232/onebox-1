module Onebox
  module Engine
    class WorldMarketOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.worldmarket\.com\/product\//)

      def price
        price_main = raw.css('#productPricing > span')
        unless price_main.inner_html.include? "-"
          Monetize.parse(price_main).cents.to_s
        end
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
          price_cents: price
        }
      end
    end
  end
end
