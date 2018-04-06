require 'httpclient'
require 'uri'

module Egauge
  class Client
    include Egauge::PowerHelpers

    def initialize(base_url)
      @client = HTTPClient.new(base_url: base_url)
    end

    def query(endpoint, options = {})
      Egauge::Response.new(client.get(endpoint, options))
    end

    private
      attr_reader :client
  end
end
