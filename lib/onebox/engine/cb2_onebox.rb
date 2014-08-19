module Onebox
  module Engine
    class CB2Onebox
      include Engine
      include HTMLEmbed

      matches_regexp(/(www.|http:\/\/(www.)?|https:\/\/(www.)?)?cb2\.com\//)

      def data
        if og_raw.is_a?(Hash)
          og_raw[:link] ||= link
          return og_raw
        end

        {
          link: link,
          title: og_raw.title,
          image: (og_raw.images.first if og_raw.images && og_raw.images.first),
          description: og_raw.description,
          type: (og_raw.type if og_raw.type),
          price_cents: Monetize.parse(raw.css('#_familyPrice > span > span.regPrice')[0]).cents.to_s
        }
      end
    end
  end
end
