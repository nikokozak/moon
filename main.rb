# encoding: utf-8

require 'tty'

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

puts table.render(:basic, padding: [0, 2, 0, 2])
