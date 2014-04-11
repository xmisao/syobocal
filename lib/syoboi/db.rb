module Syoboi
  module DB
    module TitleLookup
      def get(params = {})
        xml = REXML::Document.new(open(url(params)))

        result = Result.new

        result.code = xml.elements['TitleLookupResponse/Result/Code'].text.to_i
        result.message = xml.elements['TitleLookupResponse/Result/Message'].text

        xml.elements.each('TitleLookupResponse/TitleItems/TitleItem'){|item|
          hash = {}
          set(hash, :tid, item.elements['TID'], :int)
          set(hash, :last_update, item.elements['LastUpdate'], :time)
          set(hash, :title, item.elements['Title'], :str)
          set(hash, :short_title, item.elements['ShortTitle'], :str)
          set(hash, :title_yomi, item.elements['TitleYomi'], :str)
          set(hash, :title_en, item.elements['TitleEN'], :str)
          set(hash, :comment, item.elements['Comment'], :str)
          set(hash, :cat, item.elements['Cat'], :int)
          set(hash, :title_flag, item.elements['TitleFlag'], :int)
          set(hash, :first_year, item.elements['FirstYear'], :int)
          set(hash, :first_month, item.elements['FirstMonth'], :int)
          set(hash, :first_ch, item.elements['FirstCh'], :int)
          set(hash, :keywords, item.elements['Keywords'], :str)
          set(hash, :user_point, item.elements['UserPoint'], :int)
          set(hash, :user_point_rank, item.elements['UserPointRank'], :int)
          set(hash, :sub_titles, item.elements['SubTitles'], :int)
          result << hash
        }

        result
      end

      def url(params)
        'http://cal.syoboi.jp/db.php?Command=TitleLookup' + format_params(params)
      end

      def self.format_params(params)
        return "" if params.length == 0

        "&" + params.to_a.map{|tuple|
          tuple[0].to_s + '=' + tuple[1].to_s
        }.join('&')
      end

      def self.set(hash, key, elm, type)
        if elm
          val = nil
          if elm.text
            case type
            when :str
              val = elm.text
            when :int
              val = elm.text.to_i
            when :time
              val = Time.parse(elm.text)
            else
              raise # TODO
            end
          end
          hash[key] = val
        end
      end

      module_function :get, :url

      class Result < DelegateClass(Array)
        attr_accessor :code, :message

        def initialize
          super([])
        end
      end
    end
  end
end
