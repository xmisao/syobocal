require 'syoboi'
require 'pp'

command = ARGV[0]
params = {}
params = eval(ARGV[1]) if ARGV[1]

case command
when "CalChk"
  pp Syoboi::CalChk.get(params)
when "DB::TitleLookup"
  puts Syoboi::DB::TitleLookup.url(params)
  result = Syoboi::DB::TitleLookup.get(params)
  puts result.code
  puts result.message
  pp result
end
