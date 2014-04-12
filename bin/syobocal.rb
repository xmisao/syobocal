require 'syobocal'
require 'pp'

command = ARGV[0]
params = {}
params = eval(ARGV[1]) if ARGV[1]

$SYOBOCAL_STRICT = true

case command
when "CalChk"
  pp Syobocal::CalChk.get(params)
when "DB::TitleLookup"
  puts Syobocal::DB::TitleLookup.url(params)
  result = Syobocal::DB::TitleLookup.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  pp result
when "DB::ProgLookup"
  puts Syobocal::DB::ProgLookup.url(params)
  result = Syobocal::DB::ProgLookup.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  pp result
when "DB::ChLookup"
  puts Syobocal::DB::ChLookup.url(params)
  result = Syobocal::DB::ChLookup.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  pp result
end
