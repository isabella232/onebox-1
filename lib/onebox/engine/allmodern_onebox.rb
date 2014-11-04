module Onebox
  module Engine
    class AllmodernOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.allmodern\.com\//)

      def description
        if raw.css(".prod_features").any?
          raw.css(".prod_features")[0].inner_text.gsub("\n",'')
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
          description: description,
          type: (og_raw.type if og_raw.type),
          price_cents: Monetize.parse(raw.xpath("/html/head").xpath('//meta[@property="og:price:amount"]/@content').first.value).cents.to_s
        }
      end
    end
  end
end
