require "minitest/autorun"
require "syobocal"

class TestSection < MiniTest::Test
  include Syobocal::Comment

  def test_staff_section?
    section = Section.new(
      Element::Header1.new(
        Element::TextNode.new(
          [Element::Text.new("スタッフ")]
        )
      ),
      []
    )

    assert section.staff_section?
  end

  def test_cast_section?
    section = Section.new(
      Element::Header1.new(
        Element::TextNode.new(
          [Element::Text.new("キャスト")]
        )
      ),
      []
    )

    assert section.cast_section?
  end

  def test_link_section?
    section = Section.new(
      Element::Header1.new(
        Element::TextNode.new(
          [Element::Text.new("リンク")]
        )
      ),
      []
    )

    assert section.link_section?
  end
end
