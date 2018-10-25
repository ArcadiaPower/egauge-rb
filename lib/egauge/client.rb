require 'httpclient'
require 'csv'

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

    def csv_query(options)
      options[:c] = nil
      csv_str = client.get(EGAUGE_PATH + query_string(options)).body
      records = []
      CSV.parse(csv_str, headers: true){|l| records << l.to_h }
      records
    end

    private
      attr_reader :client

      def query_string(options)
        options.stringify_keys.map do |key, value|
          query_parameter = key.dup
          query_parameter << "=#{value.to_s}" unless value.nil?
          query_parameter
        end.join('&')
      end
  end
end
