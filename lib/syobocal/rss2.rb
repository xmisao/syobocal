module Syobocal
  module RSS2
    def get(params = {})
      parse(open(url(params)))
    end

    def url(params = {})
      "http://cal.syoboi.jp/rss2.php" + Syobocal::Util.format_params(params)
    end

    def parse(rss)
      rss = REXML::Document.new(rss)

      result = Result.new

      channel = rss.elements["rss/channel"]
      result.title = channel.elements["title"].text
      result.link = channel.elements["link"].text
      result.dc_language = channel.elements["dc:language"].text
      result.pub_date = Time.parse(channel.elements["pubDate"].text)

      rss.elements.each("rss/channel/item") { |item|
        result << {
          :title => item.elements["title"].text,
          :link => item.elements["link"].text,
          :description => item.elements["description"].text,
          :pub_date => Time.parse(item.elements["pubDate"].text),
        }
      }

      result
    end

    module_function :get, :url, :parse

    class Result < DelegateClass(Array)
      attr_accessor :title, :link, :dc_language, :pub_date

      def initialize
        super([])
      end
    end
  end
end
