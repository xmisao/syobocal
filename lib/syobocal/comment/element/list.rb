module Syobocal
  module Comment
    module Element
      class List
        attr_reader :text_node

        def initialize(text_node)
          @text_node = text_node
        end

        def ==(other)
          other.instance_of?(self.class) && other.text_node == text_node
        end

        def self.match?(line)
          line.start_with?("-")
        end

        def self.parse(line)
          txt = line.match(/\A-(.*)\Z/)[1]

          Element::List.new(Element::TextNode.parse(txt))
        end
      end
    end
  end
end
