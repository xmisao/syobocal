require "minitest/autorun"
require "syobocal"

class TestParser < MiniTest::Test
  include Syobocal::Comment

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
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    assert Parser.new(sample_comment).parse.is_a?(Element::Root)
  end

  def test_staffs_sample
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    parser = Parser.new(sample_comment)

    assert parser.staffs.first.instance_of?(Staff)
    assert_equal 22, parser.staffs.length
  end

  def test_casts_sample
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    parser = Parser.new(sample_comment)

    assert parser.casts.first.instance_of?(Cast)
    assert_equal 11, parser.casts.length
  end

  def test_links_sample
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    parser = Parser.new(sample_comment)

    assert parser.links.first.instance_of?(Element::Link)
    assert_equal 5, parser.links.length
  end

  def test_musics_sample
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    parser = Parser.new(sample_comment)

    assert parser.musics.first.instance_of?(Music)
    assert_equal 5, parser.musics.length
  end

  def test_sections_sample
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    parser = Parser.new(sample_comment)

    assert parser.sections.first.instance_of?(Section)
    assert_equal 11, parser.sections.count
  end
end
