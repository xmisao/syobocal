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
when "DB::ChGroupLookup"
  puts Syobocal::DB::ChGroupLookup.url(params)
  result = Syobocal::DB::ChGroupLookup.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  pp result
when "DB::TitleViewCount"
  puts Syobocal::DB::TitleViewCount.url(params)
  result = Syobocal::DB::TitleViewCount.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  if result.code == 200
    puts "Title: " + result.title
    puts "Type: " + result.type
    puts "Columns: " + result.columns.join(', ')
  end
  pp result
when "DB::TitleRankHistory"
  puts Syobocal::DB::TitleRankHistory.url(params)
  result = Syobocal::DB::TitleRankHistory.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  if result.code == 200
    puts "Title: " + result.title
    puts "Type: " + result.type
    puts "Columns: " + result.columns.join(', ')
  end
  pp result
when "DB::TitlePointHistory"
  puts Syobocal::DB::TitlePointHistory.url(params)
  result = Syobocal::DB::TitlePointHistory.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  if result.code == 200
    puts "Title: " + result.title
    puts "Type: " + result.type
    puts "Columns: " + result.columns.join(', ')
  end
  pp result
when "DB::TitlePointTop"
  puts Syobocal::DB::TitlePointTop.url(params)
  result = Syobocal::DB::TitlePointTop.get(params)
  puts "Code: " + result.code.to_s
  puts "Message: " + (result.message || "")
  if result.code == 200
    puts "Title: " + result.title
    puts "Type: " + result.type
    puts "Columns: " + result.columns.join(', ')
  end
  pp result
end
