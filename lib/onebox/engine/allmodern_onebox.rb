module Onebox
  module Engine
    class AllmodernOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.allmodern\.com\//)

      def title
        og_raw.title || raw.css('span.title_name').inner_html
      end

      def image
        og_raw.images && og_raw.images.first || raw.css('img.product_main_img').first['src']
      end

      def description
        return unless raw.css(".pdp_romance_copy").any?

        HTMLEntities.new.decode(raw.css(".pdp_romance_copy")[0].inner_html).
          gsub(/<[^>]+>|\s{2,}/,' ').
          gsub(/^\s+|\s+$/,'')
      end

      def type
        og_raw.type
      end

      def price
        amount = raw.xpath('/html/head/meta[@property="og:price:amount"]/@content')
        amount && Monetize.parse(amount).cents.to_s
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
          price_cents: price
        }
      end
    end
  end
end
