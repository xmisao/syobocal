require "minitest/autorun"
require "syobocal"

class TestParser < MiniTest::Test
  def test_parse_sample
    sample = JSON.parse(File.read(File.expand_path('../../samples/2077.json', __FILE__)))
    sample_comment = sample['comment']

    assert Syobocal::Comment::Parser.parse(sample_comment).is_a?(Syobocal::Comment::Parser::Result)
  end
end
