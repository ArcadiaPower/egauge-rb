module Egauge
  module PowerHelpers
    KWH_DIVIDER = 3600000

    def full_day_kwh(day = Time.zone.now.end_of_day.to_i)
      query(:C => nil, :h => nil, :n => 24, :f => day)
    end

    def monthly_kwh(number_of_months = 12)
      query(:C => nil, :T => months(number_of_months))
    end

    private

      def months(number_of_months)
        number_of_months.times.map do |number|
          number.months.ago.beginning_of_month.to_i
        end.unshift(Time.current.to_i).join(',')
      end
  end
end
