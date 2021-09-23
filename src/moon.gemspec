Gem::Specification.new do |s|
  s.name = 'mooncal'
  s.version = '0.0.1'
  s.summary = "Moon Phases!"
  s.description = "Print a moon phase calendar to your terminal!"
  s.authors = ["Nikolai Kozak"]
  s.email = "nikokozak@gmail.com"
  s.executables << "moon"
  s.files = ["lib/moon_calc.rb", "lib/moon_date.rb", "lib/moon.rb"]
  s.license = "MIT"

  s.add_runtime_dependency 'tty-table', '~> 0.12'
  s.add_runtime_dependency 'pastel', '~> 0.8'
end
