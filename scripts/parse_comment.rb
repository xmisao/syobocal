require "syobocal"
require "pp"

path = "data/db_title_lookup.json"

json = JSON.parse(File.read(path))

sections = []

json.each do |title|
  puts title["tid"]
  pp Syobocal::Comment::Parser.parse(title["comment"])
end
