require 'httpclient'

module Egauge
  class Client
    include Egauge::PowerHelpers

    EGAUGE_PATH = '/cgi-bin/egauge-show?'.freeze

    def initialize(base_url)
      @client = HTTPClient.new(base_url: base_url)
    end

    def query(options = {})
      Egauge::Response.new(client.get(EGAUGE_PATH + query_string(options)).body)
    end

    private
      attr_reader :client

      def query_string(options)
        options.stringify_keys.map do |key, value|
          query_parameter = String.new
          query_parameter << key
          query_parameter << "=#{value.to_s}" unless value.nil?
          query_parameter
        end.join('&')
      end
  end
end
