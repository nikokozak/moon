# encoding: utf-8

require_relative 'moon_term'

### PARSE ARGS ###

arg, *other_args = ARGV

case arg
when "today"
  puts MoonTerm.new.moon_day
when "week"
  puts MoonTerm.new.moon_week
when "month"
  puts MoonTerm.new.moon_month
when "-h"
  puts MoonTerm.new.help_text
when "help"
  puts MoonTerm.new.help_text
else
  puts MoonTerm.new.moon_month
end

