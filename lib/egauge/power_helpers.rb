module Egauge
  module PowerHelpers
    KWH_DIVIDER = 3600000

    def full_day_kwh(day = Time.zone.now.end_of_day.to_i)
      query(:C => nil, :h => nil, :n => 24, :f => day)
    end

    def monthly_kwh(number_of_months = 12)
      query(:C => nil, :T => months(number_of_months))
    end

    def past_24_hrs_kwh(csv=false)
      end_time = Time.now.beginning_of_hour
      ar = []
      24.times do |i|
        ar << (end_time - i.hours).to_i
      end

      options = {T: ar.join(",")}
      if csv
        csv_query(options)
      else
        query(options)
      end
    end

    private

      def months(number_of_months)
        number_of_months.times.map do |number|
          number.months.ago.beginning_of_month.to_i
        end.unshift(Time.current.to_i).join(',')
      end
  end
end
