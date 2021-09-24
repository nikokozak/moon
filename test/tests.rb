require 'test/unit'
require_relative '../lib/moon_date'
require_relative '../lib/moon'

class MoonDateTest < Test::Unit::TestCase
  def test_day_name
    assert MoonDate.new(2021, 9, 19).day_name == "Sunday"
    assert MoonDate.new(2021, 9, 20).day_name == "Monday"
    assert MoonDate.new(2021, 9, 21).day_name == "Tuesday"
    assert MoonDate.new(2021, 9, 22).day_name == "Wednesday"
    assert MoonDate.new(2021, 9, 23).day_name == "Thursday"
    assert MoonDate.new(2021, 9, 24).day_name == "Friday"
    assert MoonDate.new(2021, 9, 25).day_name == "Saturday"
  end

  def test_month_name
    assert MoonDate.new(2021, 1, 1).month_name == "January"
    assert MoonDate.new(2021, 2, 1).month_name == "February"
    assert MoonDate.new(2021, 3, 1).month_name == "March"
    assert MoonDate.new(2021, 4, 1).month_name == "April"
    assert MoonDate.new(2021, 5, 1).month_name == "May"
    assert MoonDate.new(2021, 6, 1).month_name == "June"
    assert MoonDate.new(2021, 7, 1).month_name == "July"
    assert MoonDate.new(2021, 8, 1).month_name == "August"
    assert MoonDate.new(2021, 9, 1).month_name == "September"
    assert MoonDate.new(2021, 10, 1).month_name == "October"
    assert MoonDate.new(2021, 11, 1).month_name == "November"
    assert MoonDate.new(2021, 12, 1).month_name == "December"
  end

  def test_month_days
    assert MoonDate.new(2021, 1, 1).month_days.length == 31
    assert MoonDate.new(2021, 1, 1).month_days(true).length == 7 * 5
    assert MoonDate.new(2021, 2, 1).month_days.length == 28 
    assert MoonDate.new(2021, 2, 1).month_days(true).length == 7 * 4
    assert MoonDate.new(2021, 6, 1).month_days.length == 30
    assert MoonDate.new(2021, 6, 1).month_days(true).length == 7 * 5

    assert MoonDate.new(2021, 1, 27).month_days.last === MoonDate.new(2021, 1, 31)
    assert MoonDate.new(2021, 2, 13).month_days.last === MoonDate.new(2021, 2, 28)
  end

  def test_week_days
    assert MoonDate.new(2021, 1, 10).week_days.length == 7
    assert MoonDate.new(2021, 3, 30).week_days.length == 3
    assert MoonDate.new(2021, 3, 30).week_days(true).length == 7
  end

  def test_current_week
    assert MoonDate.new(2021, 1, 1).current_week == 1
    assert MoonDate.new(2021, 1, 31).current_week == 5
  end

  def test_moon_phase
    assert MoonDate.new(2020, 1, 10).moon_phase == :full
    assert MoonDate.new(2020, 8, 19).moon_phase == :new
    assert MoonDate.new(2021, 11, 25).moon_phase == :waning_gibbous
    assert MoonDate.new(2021, 10, 31).moon_phase == :waning_crescent
    assert MoonDate.new(2022, 7, 9).moon_phase == :waxing_gibbous
    assert MoonDate.new(2022, 5, 6).moon_phase == :waxing_crescent
    assert MoonDate.new(2021, 8, 30).moon_phase == :last_quarter
    assert MoonDate.new(2023, 4, 27).moon_phase == :first_quarter
  end
end

class TermTest < Test::Unit::TestCase
  def test_moon_term_default_date
    term = MoonTerm.new
    assert term.date == Date.today
  end

  def test_moon_day_with_no_args
    term = MoonTerm.new
    to_print = term.moon_day
    assert to_print.is_a? String
    assert to_print.include?(term.date.strftime("%a, %b %e"))
    assert MoonTerm::MOONS.values.any? { |icon, full_name, _| to_print.include?(icon) && to_print.include?(full_name) }
  end

  def test_moon_week_with_no_args
    term = MoonTerm.new
    to_print = term.moon_week
    assert to_print.is_a? String
    assert to_print.include?(term.date.strftime("%b %e"))
  end

  def test_moon_month_with_no_args
    term = MoonTerm.new
    to_print = term.moon_month
    assert to_print.is_a? String
    assert make_month_dates(term.date).all? { |date| to_print.include?(date.strftime("%d")) }
  end

  def make_month_dates(date)
    (1..31).filter { |d| Date.valid_date?(date.year, date.month, d) }.map { |d| Date.new(date.year, date.month, d) }
  end
end
