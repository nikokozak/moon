require 'date'

TODAY = Date.today

class Year
  attr_reader :months
  def initialize(year=TODAY.year)
    @months = (0...12).map { |month| Month.new(year, month) }
  end
end

class Month
  MONTH_NAME = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"]

  def initialize(year=TODAY.year, month=TODAY.month)
    @name = MONTH_NAME[month - 1]
    @days = init_days(year, month)
    @year = year
    @month = month
  end

  def week(n=1)
    this_week = Date.new(@year, @month, 1).cweek + (n - 1)
    @days.filter do |day| 
      day.date.cweek == this_week
    end
  end

  private

  def init_days(year, month)
    (0..31).filter { |day| Date.valid_date?(year, month, day) }.map { |day| Day.new(year, month, day) }
  end
end

class Day
  attr_reader :date

  DAY_NAME = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]

  def initialize(year=TODAY.year, month=TODAY.month, day=TODAY.day)
    @date = Date.new(year, month, day)
    @name = DAY_NAME[@date.cwday - 1]
  end
end

