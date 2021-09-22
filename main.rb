# encoding: utf-8

require 'tty'
require_relative 'calendar'
require 'date'

DAY_NAMES = "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
TERM_HEIGHT, TERM_WIDTH = TTY::Screen.size
TODAY = Date.today

MOONS = {
 new: "\u{1F311}",
 waxing_crescent: "\u{1F312}",
 first_quarter: "\u{1F313}",
 waxing_gibbous: "\u{1F314}",
 full_moon: "\u{1F315}",
 waning_gibbous: "\u{1F316}",
 last_quarter: "\u{1F317}",
 waning_crescent: "\u{1F318}"
}

table = TTY::Table.new([[MOONS[:new], MOONS[:waxing_crescent], MOONS[:first_quarter]],
                        [MOONS[:waxing_gibbous], MOONS[:full_moon], MOONS[:waning_gibbous]]])

arg, *other_args = ARGV

def moon_today
  puts center_string("The Moon today (#{Date.today}) will be:\n\n")
  puts center_string("Waning Gibbous")
  puts center_string(MOONS[:waning_gibbous])
end

def moon_week
  headers = DAY_NAMES.zip(Date.today.week_days).map do |name, day|
    "#{name}\n#{day.strftime("%d-%m")}"
  end
  table = TTY::Table.new(headers, [])
  table << (1..7).map{ MOONS.values.shuffle.take(1)[0] }
end

def moon_month
  table = TTY::Table.new(DAY_NAMES, [])
  days = Date.today.month_days(true).map { |day| day.nil? ? day : "#{day.strftime("%d")}\n#{MOONS.values.shuffle.take(1)[0]}" }
  weeks = days.each_slice(7).to_a

  weeks.each { |week| table << week }
  table
end

def center_string(str)
  padding = ((TERM_WIDTH - str.length) / 2).floor
  str.prepend(" " * padding) 
end

case arg
when nil
  #puts moon_today
  puts moon_week.render(multiline: true, alignment: [:center], padding: [0, 1, 0, 1])
  #puts moon_month.render(multiline: true, alignment: [:center], padding:[0, 1, 0, 1])
when "week"
when "month"
  puts moon_month
  #puts moon_month
  #p Date.today.week_days
when "today"
  moon_day(TODAY)
end

def center_table(rendered_table)
  table_rows = rendered_table.split("\n")
  padding = ((TERM_WIDTH - table_rows[1].length) / 2).floor
  table_rows.map { |row| row.prepend(" " * padding) }.join("\n")
end
