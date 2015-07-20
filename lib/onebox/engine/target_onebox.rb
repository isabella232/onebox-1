module Onebox
  module Engine
    class TargetOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.target\.com\/p\//)

      def price
        price_main = raw.css('#price_main > div > p > span.offerPrice')
        price_range = raw.css('span.pricelist')
        if price_range.inner_html.empty?
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
          description: CGI::unescapeHTML(og_raw.description),
          type: (og_raw.type if og_raw.type),
          price_cents: price
        }
      end
    end
  end
end
