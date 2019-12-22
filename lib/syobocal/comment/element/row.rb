module Syobocal
  module Comment
    module Element
      class Row
        attr_reader :attr_node, :value_node

        def initialize(attr_node, value_node)
          @attr_node, @value_node = attr_node, value_node
        end

        def ==(other)
          other.instance_of?(self.class) && other.attr_node == attr_node && other.value_node == value_node
        end

        def self.match?(line)
          line.start_with?(":")
        end

        def self.parse(line)
          if line.scan(":").length == 1
            # NOTE :が1つしか含まれない行は:以降が値となる
            m = line.match(/\A:(.*)\Z/)
            attr = Element::Blank.new
            value = Element::TextNode.parse(m[1])
          else
            m = line.match(/\A:([^:]*?):(.*)\Z/)
            attr = Element::TextNode.parse(m[1])
            value = Element::TextNode.parse(m[2])
          end

          Element::Row.new(attr, value)
        end
      end
    end
  end
end
