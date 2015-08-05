module Onebox
  module Engine
    class OneKingsLaneOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.onekingslane\.com\//)

      def title
        og_raw.title
      end

      def price
        price_element = raw.css('.price .ours')[0]
        price_element && Onebox::Helpers.squish(price_element.text)
      end

      def price_cents
        Monetize.parse(price).cents.to_s
      end

      def image
        image = raw.css('img#main-image')[0]
        image && image['src']
      end

      def description
        og_raw.description
      end

      def type
        og_raw.type
      end

      def data
        {
          link: link,
          title: title,
          image: image,
          description: description,
          type: type,
          price: price,
          price_cents: price_cents
        }
      end
    end
  end
end
