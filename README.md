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
gem install syobocal
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
syobocal DB::TitleLookup "{'TID' => '1'}"
~~~~

### anime

これから放送される首都圏のアニメを表示するサンプルスクリプトです。

~~~~
anime
~~~~

## 作者

- [xmisao](http://www.xmisao.com/)

## ライセンス

This library is distributed under the MIT license.
