require "syobocal"
require "pp"

path = "data/db_title_lookup.json"

json = JSON.parse(File.read(path))

sections = []

json.each do |title|
  puts title["tid"]

  parser = Syobocal::Comment::Parser.new(title["comment"])

  pp parser.parse
  pp parser.staffs
  pp parser.casts
  pp parser.musics
  pp parser.links
end
