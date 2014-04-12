module Syobocal
  module CalChk
    def get(params = {})
      xml = REXML::Document.new(open(url(params)))

      result = Result.new

      syobocal = xml.elements['syobocal']
      result.url = syobocal.attribute("url").to_s
      result.version = syobocal.attribute("version").to_s
      result.last_update = Time.parse(syobocal.attribute("LastUpdate").to_s)
      result.spid = syobocal.attribute("SPID").to_s
      result.spname = syobocal.attribute("SPNAME").to_s

      xml.elements.each('syobocal/ProgItems/ProgItem'){|item|
        result << {
          :pid => item.attribute("PID").to_s.to_i,
          :tid => item.attribute("TID").to_s.to_i,
          :st_time => Time.parse(item.attribute("StTime").to_s),
          :ed_time => Time.parse(item.attribute("EdTime").to_s),
          :ch_name => item.attribute("ChName").to_s,
          :ch_id => item.attribute("ChID").to_s.to_i,
          :count => item.attribute("Count").to_s.to_i,
          :st_offset => item.attribute("StOffset").to_s.to_i,
          :sub_title => item.attribute("SubTitle").to_s,
          :title => item.attribute("Title").to_s,
          :prog_comment => item.attribute("ProgComment").to_s
        }
      }

      result
    end

    def url(params)
      'http://cal.syoboi.jp/cal_chk.php' + format_params(params)
    end

    def self.format_params(params)
      return "" if params.length == 0

      '?' + params.to_a.map{|tuple|
        tuple[0] + '=' + tuple[1]
      }.join('&')
    end

    module_function :get, :url

    class Result < DelegateClass(Array)
      attr_accessor :url, :version, :last_update, :spid, :spname

      def initialize
        super([])
      end
    end
  end
end
