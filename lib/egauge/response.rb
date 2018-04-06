require 'nokogiri'
require 'ostruct'

module Egauge
  class Response
    def initialize(body)
      @body = Nokogiri.parse(body)
    end

    def power_output
      # An argument could be made for using a hash instead of an openstruct here
      # I used an openstruct to get behavior like `response.header_name`
      @_output ||= begin
        columns = OpenStruct.new
        headers.each_with_index.map do |header, index|
          columns.send("#{header}=", column_content(index))
        end
        columns
      end
    end

    def headers
      @_headers ||= body.css("cname").map { |header| header.text.downcase.gsub(/\W/,"_") }
    end

    private

      attr_reader :body

      def column_content(header_index)
        rows.map { |row| row.css("c").children[header_index].text.to_i }
      end

      def rows
        @_rows ||= body.css("r")
      end
  end
end
