module Onebox
  module Engine
    class WayfairOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.wayfair\.com\//)

      def title
        if og_raw.title
          og_raw.title
        else
          raw.css('#bd > div.prodnameshare > h1').inner_html.gsub(/<[^>]+>/, '').gsub(/\n/, '').gsub(/\s{2,}/, '')
        end
      end

      def price
        if raw.xpath("/html/head").xpath('//meta[@property="og:price:amount"]/@content').empty?
          nil
        else
          Monetize.parse(raw.xpath("/html/head").xpath('//meta[@property="og:price:amount"]/@content')).cents.to_s
        end
      end

      def image
        if og_raw.images && og_raw.images.first
          og_raw.images.first
        else
          product_main_img = raw.css('img.product_main_img').first['src']
        end
      end

      def description
        if og_raw.description
          og_raw.description
        else
          raw.xpath('/html/head').xpath('//meta[@name="description"]/@content').first.value.gsub(/<[^>]+>/, '')
        end
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
