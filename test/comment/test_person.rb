require "minitest/autorun"
require "syobocal"

class TestPerson < MiniTest::Test
  include Syobocal::Comment

  def test_parse
    expect = Person.new("hoge", "piyo")
    actual = Person.parse("hoge(piyo)")

    assert_equal expect, actual
  end

  def test_valid?
    assert_equal false, Person.new("", "piyo").valid?
    assert_equal false, Person.new(nil, "piyo").valid?
    assert_equal true, Person.new("hoge", "piyo").valid?
  end
end
