module Onebox
  module Engine
    class AllmodernOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.allmodern\.com\//)

      def title
        return og_raw.title if og_raw.title
        return raw.css('span.title_name').inner_html if raw.css('span.title_name').any?
        nil
      end

      def image
        return og_raw.images.first if og_raw.images && og_raw.images.first
        raw.css('img.product_main_img').first['src']
      end

      def description
        return HTMLEntities.new.decode(raw.css(".pdp_romance_copy")[0].inner_html).
          gsub(/<[^>]+>|\s{2,}/,' ').
          gsub(/^\s+|\s+$/,'') if raw.css(".pdp_romance_copy").any?
      end

      def type
        return og_raw.type if og_raw.type
        nil
      end

      def price
        amount = raw.xpath('/html/head/meta[@property="og:price:amount"]/@content')
        return nil if amount.empty?
        Monetize.parse(amount).cents.to_s
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
