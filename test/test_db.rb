require "minitest/autorun"
require "syobocal"

module TestDB
  class TestTitleLookup < MiniTest::Test
    def setup
      @sample_params = { "TID" => "2077" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=TitleLookup&TID=2077"
      actural = Syobocal::DB::TitleLookup.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::TitleLookup.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::LookupResult
    end
  end

  class TestProgLookup < MiniTest::Test
    def setup
      @sample_params = { "Range" => "20090401_000000-20090402_000000" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=ProgLookup&Range=20090401_000000-20090402_000000"
      actural = Syobocal::DB::ProgLookup.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::ProgLookup.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::LookupResult
    end
  end

  class TestChLookup < MiniTest::Test
    def setup
      @sample_params = { "ChID" => "1" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=ChLookup&ChID=1"
      actural = Syobocal::DB::ChLookup.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::ChLookup.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::LookupResult
    end
  end

  class TestChGroupLookup < MiniTest::Test
    def setup
      @sample_params = { "ChGID" => "1" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=ChGroupLookup&ChGID=1"
      actural = Syobocal::DB::ChGroupLookup.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::ChGroupLookup.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::LookupResult
    end
  end

  class TestTitleViewCount < MiniTest::Test
    def setup
      @sample_params = { "TID" => "2077" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=TitleViewCount&TID=2077"
      actural = Syobocal::DB::TitleViewCount.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::TitleViewCount.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::TableResult
    end
  end

  class TestTitleRankHistory < MiniTest::Test
    def setup
      @sample_params = { "TID" => "2077" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=TitleRankHistory&TID=2077"
      actural = Syobocal::DB::TitleRankHistory.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::TitleRankHistory.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::TableResult
    end
  end

  class TestTitlePointHistory < MiniTest::Test
    def setup
      @sample_params = { "TID" => "2077" }
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=TitlePointHistory&TID=2077"
      actural = Syobocal::DB::TitlePointHistory.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::TitlePointHistory.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::TableResult
    end
  end

  class TestTitlePointTop < MiniTest::Test
    def setup
      @sample_params = {}
    end

    def test_url
      expected = "http://cal.syoboi.jp/db.php?Command=TitlePointTop"
      actural = Syobocal::DB::TitlePointTop.url(@sample_params)

      assert_equal expected, actural
    end

    def test_get
      result = Syobocal::DB::TitlePointTop.get(@sample_params)

      assert_equal 200, result.code
      assert result.count > 0
      assert result.is_a? Syobocal::DB::TableResult
    end
  end
end
