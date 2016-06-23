# syobocal

## 概要

syobocalは[しょぼいカレンダー](http://cal.syoboi.jp/)からデータを取得するためのRubyスクリプトです。
sch_uploadを除いて仕様が公開されている以下20種類のエンドポイントすべてに対応しています。

- cal_chk.php
- db.php
  - TitleLookup
  - ProgLookup
  - ChLookup
  - ChGroupLookup
  - TitleViewCount
  - TitleRankHistory
  - TitlePointHistory
  - TitlePointTop
- json.php
  - TitleMedium
  - TitleLarge
  - TitleFull
  - ProgramByPID
  - ProgramByCount
  - ProgramByDate
  - SubTitles
  - ChFilter
  - ChIDFilter
- rss.php
- rss2.php

## インストール

~~~~
# gem install syobocal
~~~~

## 使い方

エンドポイントごとにモジュールを切っています。
例えば`db.php`の`TitleLookup`に対応したモジュールは`Syobocal::DB::TitleLookup`です。
各モジュールには以下のモジュール関数が定義されています。

- get() -- データを取得してパースして返す
- url() -- データを取得するURLを生成して返す
- parse() -- 取得したデータをパースする

このうち`url()`と`parse()`は`get()`の内部処理のためのモジュール関数です。
基本的には`get()`にパラメータをハッシュで渡してやればデータが取得できます。
XMLやRSSをパースした結果は値が適切な型に変換されたハッシュの配列です。
JSONをパースした結果はJSONのデータ構造をそのまま返します。

~~~~
require 'syobocal'
require 'pp'
params = {"TID" => "1"}
pp Syobocal::DB::TitleLookup.get(params)
~~~~

## おまけ

テスト用の`syobocal`コマンドと、これから放送される首都圏のアニメを表示する`anime`コマンドを同梱しています。

### syobocal

各モジュールの機能をテストできるスクリプトです。
以下のようにして使います。
詳しくはソースを見て下さい。

~~~~
$ syobocal DB::TitleLookup "{'TID' => '2077'}"
http://cal.syoboi.jp/db.php?Command=TitleLookup&TID=2077
Code: 200
Message: 
[{:tid=>2077,
  :last_update=>2013-12-02 02:17:55 +0900,
  :title=>"魔法少女まどか☆マギカ",
  :short_title=>"まどか☆マギカ",
  :title_yomi=>"まほうしょうじょまどかまぎか",
  :title_en=>"PUELLA MAGI MADOKA MAGICA",
  :comment=>
   "*リンク\n-[[公式 http://www.madoka-magica.com/tv/]]\n-[[MBS http://www.mbs.jp/madoka-magica/]]\n-[[ニコニコチャンネル http://ch.nicovideo.jp/ch260]]\n-[[TOKYO MX http://www.mxtv.co.jp/madoka_magica/]]\n-[[BS11デジタル http://www.bs11.jp/anime/2360/]]\n*メモ\n-アニマックスでのリピート放送は放送日の27:00～と日曜26:00～\n*スタッフ\n:原作:Magica Quartet\n:監督:新房昭之\n:キャラクター原案:蒼樹うめ\n:キャラクターデザイン:岸田隆宏\n:シリーズ構成・脚本:虚淵玄(ニトロプラス)\n:シリーズディレクター:宮本幸裕\n:総作画監督:谷口淳一郎、高橋美香\n:アクションディレクター:阿部望、神谷智大\n:レイアウト設計:牧孝雄\n:異空間設計:劇団イヌカレー\n:美術監督:稲葉邦彦、金子雄司\n:美術設定:大原盛仁\n:色彩設計:日比野仁、滝沢いづみ\n:ビジュアルエフェクト:酒井基\n:撮影監督:江藤慎一郎\n:編集:松原理恵\n:音響監督:鶴岡陽太\n:音響制作:楽音舎\n:音楽:梶浦由記\n:音楽制作:アニプレックス\n:アニメーション制作:SHAFT\n:製作:Magica Partners(アニプレックス、芳文社、博報堂DYメディアパートナーズ、ニトロプラス、ムービック、SHAFT)、毎日放送\n*オープニングテーマ「コネクト」\n:作詞・作曲:渡辺翔\n:主題歌協力:外村敬一\n:歌:ClariS\n:使用話数:#1～#9、#11\n-#10、#12はオープニングテーマなし、エンディングテーマとして使用\n*エンディングテーマ「Magia」\n:作詞・作曲・編曲:梶浦由記\n:音楽プロデューサー:森康哲\n:歌:Kalafina\n:使用話数:#3～#8、#11(Blu-ray/DVDのみ)\n-#1、#2、#9、#11(放送版)はエンディングテーマなし\n-#1、#2、#10は挿入歌として使用\n*キャラクターエンディングソング1「また あした」\n:作詞・作曲:hanawaya\n:編曲:流歌、田口智則\n:歌:鹿目まどか(悠木碧)\n:使用話数:#1～#2(Blu-ray/DVDのみ)\n*キャラクターエンディングソング2「and I'm home」\n:作詞・作曲:wowaka\n:編曲:どく、wowaka\n:歌:美樹さやか(喜多村英梨)、佐倉杏子(野中藍)\n:使用話数:#9(Blu-ray/DVDのみ)\n*挿入歌「コネクト (ゲームインスト)」\n:作曲:渡辺翔\n:使用話数:#6\n*キャスト\n:鹿目まどか:悠木碧\n:暁美ほむら:斎藤千和\n:巴マミ／鹿目タツヤ:水橋かおり\n:美樹さやか:喜多村英梨\n:佐倉杏子:野中藍\n:キュゥべえ:加藤英美里\n:志筑仁美:新谷良子\n:鹿目詢子:後藤邑子\n:鹿目知久:岩永哲哉\n:上条恭介:吉田聖子\n:早乙女和子:岩男潤子\n*予告イラスト\n:#1:ハノカゲ\n:#2:氷川へきる\n:#3:津路参汰(ニトロプラス)\n:#4:小林尽\n:#5:ゆーぽん(ニトロプラス)\n:#6:ウエダハジメ\n:#7:天杉貴志\n:#8:藤真拓哉\n:#9:なまにくATK(ニトロプラス)\n:#10:ムラ黒江\n:#11:ブリキ\n*エンドイラスト\n:#12:蒼樹うめ",
  :cat=>10,
  :title_flag=>0,
  :first_year=>2011,
  :first_month=>1,
  :first_end_year=>2011,
  :first_end_month=>4,
  :first_ch=>"MBS",
  :keywords=>"wikipedia:魔法少女まどか☆マギカ",
  :user_point=>265,
  :user_point_rank=>256,
  :sub_titles=>
   "*01*夢の中で会った、ような・・・・・\n*02*それはとっても嬉しいなって\n*03*もう何も恐くない\n*04*奇跡も、魔法も、あるんだよ\n*05*後悔なんて、あるわけない\n*06*こんなの絶対おかしいよ\n*07*本当の気持ちと向き合えますか？\n*08*あたしって、ほんとバカ\n*09*そんなの、あたしが許さない\n*10*もう誰にも頼らない\n*11*最後に残った道しるべ\n*12*わたしの、最高の友達"}]
~~~~

### syobocal-anime

これから放送される首都圏のアニメを表示するサンプルスクリプトです。

~~~~
$ syobocal-anime
これから放送されるアニメ＠首都圏
25:25 [フジテレビ] 暗殺教室(第2期) / 卒業の時間
25:58 [TBS] 少年メイド / 少年よ、大志を抱け
26:28 [TBS] 坂本ですが？ / ぬくもりはいらない／1-2メモリーズ
26:35 [テレビ東京] あにむす！ / 
26:58 [TBS] マギ シンドバッドの冒険 / 天空都市アルテミュラ
~~~~

## 作者

- [xmisao](http://www.xmisao.com/)

## ライセンス

This library is distributed under the MIT license.
