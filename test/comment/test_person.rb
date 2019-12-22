require "minitest/autorun"
require "syobocal"

class TestPerson < MiniTest::Test
  include Syobocal::Comment

  def test_parse
    expect = Person.new("hoge", "piyo")
    actual = Person.parse("hoge(piyo)")

    assert_equal expect, actual
  end
end
