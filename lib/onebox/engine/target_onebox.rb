module Onebox
  module Engine
    class TargetOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.target\.com\/p\//)

      def price
        price_main = raw.css('#price_main > div > p > span.offerPrice')
        return nil if price_main.inner_html.include? "-"
        Monetize.parse(price_main).cents.to_s
      end

      def description
        HTMLEntities.new.decode(og_raw.description).gsub(/<[^>]+>/, '')
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
          price_cents: price
        }
      end
    end
  end
end
