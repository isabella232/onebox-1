module Onebox
  module Engine
    class WayfairOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.wayfair\.com\//)

      def title
        return og_raw.title if og_raw.title
        raw.css('#bd > div.prodnameshare > h1').inner_html.gsub(/<[^>]+>|\n|\s{2,}/, '')
      end

      def price
        amount = raw.xpath('/html/head/meta[@property="og:price:amount"]/@content')
        return nil if amount.empty?
        Monetize.parse(amount).cents.to_s
      end

      def image
        return og_raw.images.first if og_raw.images && og_raw.images.first
        raw.css('img.product_main_img').first['src']
      end

      def description
        return og_raw.description if og_raw.description
        raw.xpath('/html/head/meta[@name="description"]/@content').first.value.gsub(/<[^>]+>/, '')
      end

      def type
        og_raw.type
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
