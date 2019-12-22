require "minitest/autorun"
require "syobocal"

class TestTextNode < MiniTest::Test
  include Syobocal::Comment::Element

  def test_inner_text
    node = TextNode.new([Text.new("hoge"), Link.new("piyo", "http://example.com")])

    assert_equal "hogepiyo", node.inner_text
  end

  def test_split
    node = TextNode.new([Text.new("hoge、"), Link.new("piyo、", "http://example.com"), Text.new("、foo(bar、baz)")])

    assert_equal ["hoge", "piyo、", "foo(bar、baz)"], node.split
  end
end
