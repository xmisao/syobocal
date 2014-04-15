module Syobocal
  module JSON
    module TitleMedium
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=TitleMedium' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module TitleLarge
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=TitleLarge' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module TitleFull
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=TitleFull' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module ProgramByPID
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=ProgramByPID' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module ProgramByCount
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=ProgramByCount' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module ProgramByDate
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=ProgramByData' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module SubTitles
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=SubTitles' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module ChFilter
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=ChFilter' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end

    module ChIDFilter
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params = {})
        'http://cal.syoboi.jp/json.php?Req=ChIDFilter' + Syobocal::Util.format_params_amp(params)
      end

      def parse(json)
        ::JSON.load(json)
      end

      module_function :get, :url, :parse
    end
  end
end
