module Syobocal
  module SubTitles
    class Parser
      FORMAT_REGEXP = /\A\*(.*?)\*(.*)\Z/

      def initialize(sub_titles)
        @sub_titles = sub_titles
      end

      def parse
        return @parse if defined? @parse

        @sub_titles.each_line.each_with_object([]){|line, array|
          m = FORMAT_REGEXP.match(line)

          array << SubTitle.new(m[1], m[2]) if m
        }
      end
    end
  end
end
