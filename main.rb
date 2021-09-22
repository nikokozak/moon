# encoding: utf-8

require 'tty'

TERM_HEIGHT, TERM_WIDTH = TTY::Screen.size

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

def center(rendered_table)
  table_rows = rendered_table.split("\n")
  padding = ((TERM_WIDTH - table_rows[1].length) / 2).floor
  table_rows.map { |row| row.prepend(" " * padding) }.join("\n")
end

puts center(table.render(:basic, padding: [0, 2, 0, 2]))
