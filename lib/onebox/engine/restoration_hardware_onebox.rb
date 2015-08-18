module Onebox
  module Engine
    class RestorationHardwareOnebox
      include Engine
      include HTMLEmbed

      matches_regexp(/^https:\/\/(?:www)\.restorationhardware\.com\//)

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

      private

      def http_params
        {"User-Agent" => "Mozilla/5.0 (Windows; Windows NT 5.1; en-US) Firefox/3.5.0"}
      end

      def fetch_response(location, limit = 5, domain = nil)
        raise Net::HTTPError.new('HTTP redirect too deep', location) if limit == 0

        uri = URI(location)
        if !uri.host
          uri = URI("#{domain}#{location}")
        end
        http = Net::HTTP.new(uri.host, uri.port)
        http.open_timeout = Onebox.options.connect_timeout
        http.read_timeout = Onebox.options.timeout
        if uri.is_a?(URI::HTTPS)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end

        response = http.request_get(uri.request_uri, {"User-Agent" => "Mozilla/5.0 (Windows; Windows NT 5.1; en-US) Firefox/3.5.0"})

        case response
        when Net::HTTPSuccess     then response
        when Net::HTTPRedirection then fetch_response(response['location'], limit - 1, "#{uri.scheme}://#{uri.host}")
        else
          response.error!
        end
      end
    end
  end
end
