# encoding: utf-8

require 'tty'
require 'pastel'
require_relative 'calendar'

$pastel = Pastel.new

### CONSTANTS ###

TERM_HEIGHT, TERM_WIDTH = TTY::Screen.size

DAY_NAMES = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
]

MOONS = {
  new: ["\u{1F311}", "New Moon", "New"],
  waxing_crescent: ["\u{1F312}", "Waxing Crescent", "WxC"],
  first_quarter: ["\u{1F313}", "First Quarter", "FQ"],
  waxing_gibbous: ["\u{1F314}", "Waxing Gibbous", "WxG"],
  full: ["\u{1F315}", "Full Moon", "Full"],
  waning_gibbous: ["\u{1F316}", "Waning Gibbous", "WnG"],
  last_quarter: ["\u{1F317}", "Last Quarter", "LQ"],
  waning_crescent: ["\u{1F318}", "Waning Crescent", "WnC"]
}

### MAIN ###

class MoonTerm
  def initialize(date=MoonDate.today)
    @date = date
  end

  def moon_day
    header_string = "The Moon today (#{@date.strftime("%a, %b %e")}):\n"
    phase_string = $pastel.bold(MOONS[@date.moon_phase][1]) + "\n"
    moon_icon = MOONS[@date.moon_phase][0] + "\n"

    puts center_string(header_string)
    puts center_string(phase_string)
    puts center_string(moon_icon)
  end

  def moon_week
    table = TTY::Table.new(DAY_NAMES, [])

    ## FIX DEALING WITH NIL VALS
    puts center_string($pastel.bold("Moon Phases for the #{number_ord(@date.current_week)} week of #{@date.strftime("%B")}"))
    puts ""
    table << @date.month_days(true).each_slice(7).to_a[@date.current_week - 1].map do |day|
      if day == @date then $pastel.bold(day.strftime("%b %e"))
      elsif !day.nil? then day.strftime("%b %e")
      else day
      end
    end
    table << @date.week_days.map { |day| day.nil? ? day : MOONS[day.moon_phase][0] }

    puts center_table(table.render(multiline: true, alignment: [:center], padding: [0, 2, 0, 2]))
  end

  def moon_month
    table = TTY::Table.new(DAY_NAMES, [])
    days = @date.month_days(true).map do |day| 
      day.nil? ? day : (day == @date) ? "#{$pastel.bold(day.strftime("%d"))}\n#{MOONS[day.moon_phase][0]}" : "#{day.strftime("%d")}\n#{MOONS[day.moon_phase][0]}"
    end
    weeks = days.each_slice(7).to_a

    weeks.each { |week| table << week }

    puts center_string($pastel.bold("Moon Phases for #{@date.strftime("%B %Y")}"))
    puts ""
    puts center_table(table.render(multiline: true, alignment: [:center], padding:[0, 1, 0, 1]))
  end

  private

  def number_ord(num)
    case num
    when 1 then num.to_s + "st"
    when 2 then num.to_s + "nd"
    when 3 then num.to_s + "rd"
    else num.to_s + "th"
    end
  end

  def center_string(str, width=TERM_WIDTH)
    padding = ((width - $pastel.strip(str).length) / 2).floor
    str.strip.prepend(" " * padding) 
  end

  def center_table(rendered_table)
    table_rows = rendered_table.split("\n")
    padding = ((TERM_WIDTH - table_rows[1].length) / 2).floor
    table_rows.map { |row| row.prepend(" " * padding) }.join("\n")
  end
end

### PARSE ARGS ###

arg, *other_args = ARGV

case arg
when "day"
  MoonTerm.new.moon_day
when "week"
  MoonTerm.new.moon_week
when "month"
  MoonTerm.new.moon_month
else
  MoonTerm.new.moon_month
end

