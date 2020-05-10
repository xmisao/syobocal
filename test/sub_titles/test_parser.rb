require "minitest/autorun"
require "syobocal"

module Syobocal
  module SubTitles
    class TestParser < MiniTest::Test
      def test_parse
        sub_titles = <<SUB_TITLES
*01*hoge
*02*hoge*piyo
03
*04*
**

SUB_TITLES

        expected = [
          SubTitle.new("01", "hoge"),
          SubTitle.new("02", "hoge*piyo"),
          SubTitle.new("04", ""),
          SubTitle.new("", ""),
        ]

        actual = Parser.new(sub_titles).parse

        assert_equal actual, expected
      end

      def test_parse_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_sub_titles = sample["sub_titles"]

        expected = [
          SubTitle.new("01", "夢の中で会った、ような・・・・・"),
          SubTitle.new("02", "それはとっても嬉しいなって"),
          SubTitle.new("03", "もう何も恐くない"),
          SubTitle.new("04", "奇跡も、魔法も、あるんだよ"),
          SubTitle.new("05", "後悔なんて、あるわけない"),
          SubTitle.new("06", "こんなの絶対おかしいよ"),
          SubTitle.new("07", "本当の気持ちと向き合えますか？"),
          SubTitle.new("08", "あたしって、ほんとバカ"),
          SubTitle.new("09", "そんなの、あたしが許さない"),
          SubTitle.new("10", "もう誰にも頼らない"),
          SubTitle.new("11", "最後に残った道しるべ"),
          SubTitle.new("12", "わたしの、最高の友達"),
        ]

        actual = Parser.new(sample_sub_titles).parse

        assert_equal actual, expected
      end
    end
  end
end
