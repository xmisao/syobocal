require 'syoboi'

def format_time(time)
  h = time.hour
  h += 24 if h < 5
  m = time.min

  sprintf("%2d:%02d", h, m)
end

result = Syoboi::CalChk.get()

puts "これから放送されるアニメ＠首都圏\n"

result.select{|prog|
  # 現在から
  st = Time.now

  # 次の朝5時まで
  day = Time.now.hour < 5 ? Date.today : Date.today + 1
  ed = Time.new(day.year, day.month, day.day, 5)

  # 首都圏のチャンネルで放送されるアニメ
  syutoken_ch = [
    1, # NHK総合
    2, # NHK Eテレ
    3, # フジテレビ
    4, # 日本テレビ
    5, # TBS
    6, # テレビ朝日
    7, # テレビ東京
    8, # TVK
    13, # チバテレビ
    14, # テレ玉
    19, # TOKYO MX
  ]

  st < prog[:st_time] and prog[:st_time] < ed and syutoken_ch.include?(prog[:ch_id])
}.sort_by{|prog|
  prog[:st_time] # 放送開始日時で降順に並べ替え
}.each{|prog|
  puts "#{format_time(prog[:st_time])} [#{prog[:ch_name]}] #{prog[:title]} / #{prog[:sub_title]}"
}
