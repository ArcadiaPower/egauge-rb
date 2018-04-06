module Egauge
  module PowerHelpers
    KWH_DIVIDER = 3600000

    def full_day_kwh
      full_day_kwh = {}
      response = query("/cgi-bin/egauge-show?#{yesterday_query}")
      response.headers.each do |header|
        full_day_kwh[header] = calculate_kwh(response.send(header))
      end
      full_day_kwh
    end

    private

      def calculate_kwh(power_output)
        (power_output.first - power_output.last) / KWH_DIVIDER
      end

      def yesterday_query
        "h&n=24&f=#{Date.yesterday.beginning_of_day.to_i}"
      end
  end
end
