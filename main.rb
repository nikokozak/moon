# encoding: utf-8

require 'curses'

include Curses

init_screen
start_color
curs_set(0)

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

begin
  MOONS.values.each { |moon| stdscr << moon }
  getch
ensure
  close_screen
end

