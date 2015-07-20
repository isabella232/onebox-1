module Onebox
  module Engine
    class OverstockOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.overstock\.com\//)

      def itemnumber
        if raw.css('.description-item-number').any?
          raw.css('.description-item-number')[0].inner_text
        end
      end

      def description
        if raw.css('div.description.toggle-content').any?
          escaped = raw.css('div.description.toggle-content').inner_html.
            gsub(/<\/?[^>]*>/, " ").
            gsub(/#{Regexp.quote(itemnumber)}|(\r)/, "").
            gsub(/\s+/, " ").
            gsub(/^\s*|(\s*$)/, "")
          CGI::unescapeHTML(escaped)
        end
      end

      def productname
        return og_raw.title.gsub(/ \|.*/, "") if og_raw.title
        return raw.css('title').inner_html.gsub(/ \|.*/, "") if raw.css('title').any?
      end

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: productname,
          image: (og_raw.images.first if og_raw.images && og_raw.images.first),
          description: description,
          type: (og_raw.type if og_raw.type),
          price_cents: Monetize.parse(raw.xpath('//span[@itemprop="price"]').children).cents.to_s
        }
      end
    end
  end
end
