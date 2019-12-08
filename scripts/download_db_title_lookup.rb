require "syobocal"

path = "data/db_title_lookup.json"

if File.exist? path
  puts "Nothing to do. '#{path}' already exists."
else
  puts "Downloading to '#{path}'."

  open(path, "w") do |f|
    f.print JSON.pretty_generate(Syobocal::DB::TitleLookup.get({ "TID" => "*" }))
  end

  puts "Completed."
end
