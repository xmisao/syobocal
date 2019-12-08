module Syobocal
  module RSS
    def get(params = {})
      parse(open(url(params)))
    end

    def url(params = {})
      "http://cal.syoboi.jp/rss.php" + Syobocal::Util.format_params(params)
    end

    def parse(rss)
      rss = REXML::Document.new(rss)

      result = Result.new

      channel = rss.elements["rdf:RDF/channel"]
      result.title = channel.elements["title"].text
      result.link = channel.elements["link"].text
      result.description = channel.elements["description"].text

      rss.elements.each("rdf:RDF/item") { |item|
        tv = item.elements["tv:feed"]
        result << {
          :about => item.attribute("rdf:about").to_s,
          :title => item.elements["title"].text,
          :link => item.elements["link"].text,
          :description => item.elements["description"].text,
          :dc_date => Time.parse(item.elements["dc:date"].text),
          :dc_publisher => item.elements["dc:publisher"].text,
          :tv_genre => tv.elements["tv:genre"].text,
          :tv_start_datetime => Time.parse(tv.elements["tv:startDatetime"].text),
          :tv_end_datetime => Time.parse(tv.elements["tv:endDatetime"].text),
          :tv_iepg_url => tv.elements["tv:iepgUrl"].text,
          :tv_performer => tv.elements["tv:performer"].text,
        }
      }

      result
    end

    module_function :get, :url, :parse

    class Result < DelegateClass(Array)
      attr_accessor :title, :link, :description

      def initialize
        super([])
      end
    end
  end
end
