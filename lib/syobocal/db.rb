module Syobocal
  module DB
    module TitleLookup
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=TitleLookup' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        xml = REXML::Document.new(xml)

        result = LookupResult.new

        result.code = xml.elements['TitleLookupResponse/Result/Code'].text.to_i
        result.message = xml.elements['TitleLookupResponse/Result/Message'].text

        xml.elements.each('TitleLookupResponse/TitleItems/TitleItem'){|item|
          mapper = Mapper.new
          result << mapper.map(item)
        }

        result
      end

      module_function :get, :url, :parse


      class Mapper
        include Syobocal::Util::Mapper::ElementsMapper

        def initialize
          @map = {
            "TID" => :int,
            "LastUpdate" => :time,
            "Title" => :str,
            "ShortTitle" => :str,
            "TitleYomi" => :str,
            "TitleEN" => :str,
            "Comment" => :str,
            "Cat" => :int,
            "TitleFlag" => :int,
            "FirstYear" => :int,
            "FirstMonth" => :int,
            "FirstEndYear" => :int,
            "FirstEndMonth" => :int,
            "FirstCh" => :int,
            "Keywords" => :str,
            "UserPoint" => :int,
            "UserPointRank" => :int,
            "SubTitles" => :str,
          }
        end
      end
    end

    module ProgLookup
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=ProgLookup' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        xml = REXML::Document.new(xml)

        result = LookupResult.new

        result.code = xml.elements['ProgLookupResponse/Result/Code'].text.to_i
        result.message = xml.elements['ProgLookupResponse/Result/Message'].text

        xml.elements.each('ProgLookupResponse/ProgItems/ProgItem'){|item|
          mapper = Mapper.new
          result << mapper.map(item)
        }

        result
      end

      module_function :get, :url, :parse

      class Mapper
        include Syobocal::Util::Mapper::ElementsMapper

        def initialize
          @map = {
            "LastUpdate" => :time,
            "PID" => :int,
            "TID" => :int,
            "StTime" => :time,
            "StOffset" => :int,
            "EdTime" => :time,
            "Count" => :int,
            "SubTitle" => :str,
            "ProgComment" => :str,
            "Flag" => :int,
            "Deleted" => :int,
            "Warn" => :int,
            "ChID" => :int,
            "Revision" => :int,
            "STSubTitle" => :str,
          }
        end
      end
    end

    module ChLookup
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=ChLookup' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        xml = REXML::Document.new(xml)

        result = LookupResult.new

        result.code = xml.elements['ChLookupResponse/Result/Code'].text.to_i
        result.message = xml.elements['ChLookupResponse/Result/Message'].text

        xml.elements.each('ChLookupResponse/ChItems/ChItem'){|item|
          mapper = Mapper.new
          result << mapper.map(item)
        }

        result
      end

      module_function :get, :url, :parse

      class Mapper
        include Syobocal::Util::Mapper::ElementsMapper

        def initialize
          @map = {
            "LastUpdate" => :time,
            "ChID" => :int,
            "ChName" => :str,
            "ChiEPGName" => :str,
            "ChURL" => :str,
            "ChEPGURL" => :str,
            "ChComment" => :str,
            "ChGID" => :int,
            "ChNumber" => :int,
          }
        end
      end
    end

    module ChGroupLookup
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=ChGroupLookup' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        xml = REXML::Document.new(xml)

        result = LookupResult.new

        result.code = xml.elements['ChGroupLookupResponse/Result/Code'].text.to_i
        result.message = xml.elements['ChGroupLookupResponse/Result/Message'].text

        xml.elements.each('ChGroupLookupResponse/ChGroupItems/ChGroupItem'){|item|
          mapper = Mapper.new
          result << mapper.map(item)
        }

        result
      end

      module_function :get, :url, :parse

      class Mapper
        include Syobocal::Util::Mapper::ElementsMapper

        def initialize
          @map = {
            "LastUpdate" => :time,
            "ChGID" => :int,
            "ChGroupName" => :str,
            "ChGroupComment" => :str,
            "ChGroupOrder" => :int,
          }
        end
      end
    end

    module TitleViewCount
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=TitleViewCount' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        Syobocal::DB.parse_table_data(xml)
      end

      module_function :get, :url, :parse
    end

    module TitleRankHistory
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=TitleRankHistory' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        Syobocal::DB.parse_table_data(xml)
      end

      module_function :get, :url, :parse
    end

    module TitlePointHistory
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=TitlePointHistory' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        Syobocal::DB.parse_table_data(xml)
      end

      module_function :get, :url, :parse
    end

    module TitlePointTop
      def get(params = {})
        parse(open(url(params)))
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=TitlePointTop' + Syobocal::DB.format_params_amp(params)
      end

      def parse(xml)
        Syobocal::DB.parse_table_data(xml)
      end

      module_function :get, :url, :parse
    end

    def self.format_params_amp(params)
      return "" if params.length == 0

      "&" + params.to_a.map{|tuple|
        tuple[0].to_s + '=' + tuple[1].to_s
      }.join('&')
    end

    def self.parse_table_data(xml)
      xml = REXML::Document.new(xml)

      result = TableResult.new

      result.code = xml.elements['TableData/Result/Code'].text.to_i
      result.message = xml.elements['TableData/Result/Message'].text

      result.columns = []
      if result.code == 200
        result.title = xml.elements['TableData/Title'].text
        result.type = xml.elements['TableData/Type'].text

        xml.elements.each('TableData/Columns/Value'){|item|
          result.columns << item.text
        }

        xml.elements.each('TableData/Line'){|line|
          line_data = {}
          line.elements.each_with_index{|value, index|
            key = result.columns[index]
            if key == "Date"
              line_data[key] = Date.parse(value.text)
            else
              line_data[key] = value.text ? value.text.to_i : nil
            end
          }
          result << line_data
        }
      end

      result
    end

    class LookupResult < DelegateClass(Array)
      attr_accessor :code, :message

      def initialize
        super([])
      end
    end

    class TableResult < DelegateClass(Array)
      attr_accessor :code, :message, :title, :type, :columns

      def initialize
        super([])
      end
    end
  end
end
