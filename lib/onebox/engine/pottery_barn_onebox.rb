module Onebox
  module Engine
    class PotteryBarnOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^http:\/\/(?:www)\.potterybarn\.com\//)

      def title
        og_raw.title
      end

      def price
        amount = raw.css('.product-price')[0].text
        amount.empty? ? nil : Onebox::Helpers.squish(amount)
      end

      def price_cents
        Monetize.parse(price).cents.to_s
      end

      def image
        image = raw.css('img#hero')[0]
        image['src'] if image
      end

      def description
        paragraph = raw.css('.pip-summary > .accordion-component > dd p')[0]
        return unless paragraph
        Onebox::Helpers.squish(paragraph.text)
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
