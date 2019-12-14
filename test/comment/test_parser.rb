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

    actual = Parser.new.parse(comment)

    assert_equal expected, actual
  end

  def test_parse_sample
    sample = JSON.parse(File.read(File.expand_path("../../samples/2077.json", __FILE__)))
    sample_comment = sample["comment"]

    assert Parser.new.parse(sample_comment).is_a?(Element::Root)
  end
end
