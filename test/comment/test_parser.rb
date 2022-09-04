require "minitest/autorun"
require "syobocal"

module Syobocal
  module Comment
    class TestParser < MiniTest::Test
      def test_parse
        comment = <<COMMENT
*hoge
**piyo
***fuga
:foo
:foo:bar
:foo:bar:baz
-hogera
Hello, World!
[[Hello, World!]]
[[Hello, World! http://example.com]]

COMMENT
        expected_elements = [
          Element::Header1.new(
            Element::TextNode.new(
              [Element::Text.new("hoge")]
            )
          ),
          Element::Header2.new(
            Element::TextNode.new(
              [Element::Text.new("piyo")]
            )
          ),
          Element::Header2.new(
            Element::TextNode.new(
              [Element::Text.new("*fuga")]
            )
          ),
          Element::Row.new(
            Element::Blank.new,
            Element::TextNode.new(
              [Element::Text.new("foo")]
            )
          ),
          Element::Row.new(
            Element::TextNode.new(
              [Element::Text.new("foo")]
            ),
            Element::TextNode.new(
              [Element::Text.new("bar")]
            )
          ),
          Element::Row.new(
            Element::TextNode.new(
              [Element::Text.new("foo")]
            ),
            Element::TextNode.new(
              [Element::Text.new("bar:baz")]
            )
          ),
          Element::List.new(
            Element::TextNode.new(
              [Element::Text.new("hogera")]
            )
          ),
          Element::TextNode.new(
            [Element::Text.new("Hello, World!")]
          ),
          Element::TextNode.new(
            [
              Element::Link.new("Hello, World!", nil),
            ]
          ),
          Element::TextNode.new(
            [
              Element::Link.new("Hello, World!", "http://example.com"),
            ]
          ),
          Element::Blank.new,
        ]
        expected = Element::Root.new(expected_elements)
        actual = Parser.new(comment).parse

        assert_equal expected, actual
      end

      def test_parse_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_comment = sample["comment"]

        assert Parser.new(sample_comment).parse.is_a?(Element::Root)
      end

      def test_staffs_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        expect = Staff.new("原作", [Person.new("Magica Quartet", nil)])
        assert_equal expect, parser.staffs.first

        assert_equal 22, parser.staffs.length
      end

      def test_staffs_not_include_invalid_people
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/116.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        assert parser.staffs.all? { |staff|
          staff.people.none? { |person| person.name == nil }
        }
      end

      def test_casts_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        expect = Cast.new("鹿目まどか", [Person.new("悠木碧", nil)])
        assert_equal expect, parser.casts.first

        assert_equal 11, parser.casts.length
      end

      def test_casts_sample_not_include_invalid_people
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/91.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        assert parser.casts.all? { |cast|
          cast.people.none? { |person| person.name == nil }
        }
      end

      def test_links_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        expect = Element::Link.new("公式", "http://www.madoka-magica.com/tv/")
        assert_equal expect, parser.links.first

        assert_equal 5, parser.links.length
      end

      def test_musics_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        expect = Music.new(
          "コネクト",
          "オープニングテーマ",
          [
            MusicData.new("作詞・作曲", "作詞・作曲", nil, "渡辺翔", [Person.new("渡辺翔", nil)]),
            MusicData.new("主題歌協力", "主題歌協力", nil, "外村敬一", [Person.new("外村敬一", nil)]),
            MusicData.new("歌", "歌", nil, "ClariS", [Person.new("ClariS", nil)]),
            MusicData.new("使用話数", "使用話数", nil, "#1～#9、#11", [Person.new("#1～#9", nil), Person.new("#11", nil)]),
          ]
        )
        assert_equal expect, parser.musics.first

        assert_equal 5, parser.musics.length
      end

      def test_sections_sample
        sample = ::JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
        sample_comment = sample["comment"]

        parser = Parser.new(sample_comment)

        assert parser.sections.first.instance_of?(Section)
        assert_equal 11, parser.sections.count
      end
    end
  end
end
