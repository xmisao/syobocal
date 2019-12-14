module Syobocal
  module Comment
    class Parser
      ELEMENT_CLASSES = [
        Element::Header2,
        Element::Header1,
        Element::List,
        Element::Row,
        Element::Blank,
        Element::TextNode, # NOTE Sentinel
      ]

      def parse(str)
        return Element::Root.new([]) unless str

        elements = str.each_line.map do |line|
          line.chomp!
          ELEMENT_CLASSES.find { |clazz| clazz.match?(line) }.parse(line)
        end

        Element::Root.new(elements)
      end
    end
  end
end
