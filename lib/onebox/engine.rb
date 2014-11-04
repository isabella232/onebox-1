module Onebox
  module Engine
    def self.included(object)
      object.extend(ClassMethods)
    end

    def self.engines
      constants.select do |constant|
        constant.to_s =~ /Onebox$/
      end.map(&method(:const_get))
    end

    attr_reader :url
    attr_reader :cache
    attr_reader :timeout

    def initialize(link, cache = nil, timeout = nil)
      @url = link
      @cache = cache || Onebox.options.cache
      @timeout = timeout || Onebox.options.timeout
    end

    # raises error if not defined in onebox engine. This is the output method for
    # an engine.
    def to_html
      fail NoMethodError, "Engines need to implement this method"
    end

    # Some oneboxes create iframes or other complicated controls. If you're using
    # a live editor with HTML preview, rendering those complicated controls can
    # be slow or cause flickering.
    #
    # This method allows engines to produce a placeholder such as static image
    # frame of a video.
    #
    # By default it just calls `to_html` unless implemented.
    def placeholder_html
      to_html
    end

    private

    def record
      result = cache.fetch(url) { data }
      cache[url] = result if cache.respond_to?(:key?)
      result
    end

    # raises error if not defined in onebox engine
    # in each onebox, uses either Nokogiri or StandardEmbed to get raw HTML from url
    def raw
      fail NoMethodError, "Engines need to implement this method"
    end

    # raises error if not defined in onebox engine
    # in each onebox, returns hash of desired onebox content
    def data
      fail NoMethodError, "Engines need this method defined"
    end

    def link
      @url.gsub(/['\"<>]/, {
        "'" => '&#39;',
        '&' => '&amp;',
        '"' => '&quot;',
        '<' => '&lt;',
        '>' => '&gt;',
      })
    end

    module ClassMethods
      def ===(other)
        if other.kind_of?(URI)
          !!(other.to_s =~ class_variable_get(:@@matcher))
        else
          super
        end
      end

      def priority
        100
      end

      def matches_regexp(r)
        class_variable_set :@@matcher, r
      end

      # calculates a name for onebox using the class name of engine
      def onebox_name
        name.split("::").last.downcase.gsub(/onebox/, "")
      end

    end
  end
end

require_relative "helpers"
require_relative "layout_support"
require_relative "engine/standard_embed"
require_relative "engine/html_embed"
require_relative "engine/html"
require_relative "engine/json"
require_relative "engine/amazon_onebox"
require_relative "engine/image_onebox"
require_relative "engine/whitelisted_generic_onebox"
# custom engines
require_relative "engine/allmodern_onebox"
require_relative "engine/CB2_onebox"
require_relative "engine/crate_and_barrel_onebox"
require_relative "engine/ikea_onebox"
require_relative "engine/one_kings_lane_onebox"
require_relative "engine/overstock_onebox"
require_relative "engine/target_onebox"
require_relative "engine/wayfair_onebox"
require_relative "engine/world_market_onebox"
