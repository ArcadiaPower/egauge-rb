require 'nokogiri'

module Egauge
  class Response
    KWH_DIVIDER = 3600000

    def initialize(body)
      @body = Nokogiri.parse(body)
      load_power_output
    end

    def headers
      @_headers ||= body.css("cname").map { |header| header.text.downcase.gsub(/\W/,"_") }
    end

    private

      attr_reader :body

      def column_content(header_index)
        rows.map { |row| (row.css("c").children[header_index].text.to_i / KWH_DIVIDER).abs }
      end

      def rows
        @_rows ||= body.css("r")
      end

      def load_power_output
        headers.each_with_index do |header, index|
          self.class.send(:define_method, header) { column_content(index) }
        end
      end
  end
end
