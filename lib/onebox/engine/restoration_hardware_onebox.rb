module Onebox
  module Engine
    class RestorationHardwareOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.restorationhardware\.com\//)

      def title
        og_raw.title
      end

      def price
        amount = raw.css('[itemprop=price]')[0]
        amount && Onebox::Helpers.squish(amount.text)
      end

      def price_cents
        Monetize.parse(price).cents.to_s
      end

      def image
        image = raw.css('#default-photo')[0]
        return unless image
        src = image['src']
        "http:#{src}"
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
