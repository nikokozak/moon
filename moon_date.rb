require 'date'
require_relative 'moon'

class MoonDate < Date
  DAY_NAME = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
  MONTH_NAME = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"]

  def week_days(padded=false)
    week_days = month_days.filter { |day| day.cweek == self.cweek }
    padded ? pad_days(week_days) : week_days 
  end

  def current_week
    naive_cweek(self) - naive_cweek(MoonDate.new(self.year, self.month, 1)) + 1
  end

  def day_name
    DAY_NAME[self.cwday - 1]
  end

  def month_name
    MONTH_NAME[self.month - 1]
  end

  def month_days(padded=false)
    days = (0..31).filter { |day| Date.valid_date?(self.year, self.month, day) }.map do |day|
      MoonDate.new(self.year, self.month, day)
    end

    padded ? pad_days(days) : days
  end

  def moon_phase
    Moon.new(self).phase
  end

  private

  def pad_days(days)
    front_padding = days.first.cwday - 1
    end_padding = 7 - days.last.cwday 

    Array.new(front_padding, nil) + days + Array.new(end_padding, nil)
  end

  def naive_cweek(date)
    date.month == 1 && date.cweek == 53 ? 1 : date.month_days.first.cweek == 53 ? date.cweek + 1 : date.cweek
  end
end

