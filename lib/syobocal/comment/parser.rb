module Syobocal
  module Comment
    module Parser
      def parse(str)
        return Result.new([]) unless str

        elements = []

        str.each_line do |line|
          line.chomp!

          if line.start_with?("**")
            txt = line.match(/\A\*\*(.*)\Z/)[1]

            elements << Element::Header2.new(parse_text_node(txt))
          elsif line.start_with?("*")
            txt = line.match(/\A\*(.*)\Z/)[1]

            elements << Element::Header1.new(parse_text_node(txt))
          elsif line.start_with?("-")
            txt = line.match(/\A-(.*)\Z/)[1]

            elements << Element::List.new(parse_text_node(txt))
          elsif line.start_with?(":")
            if line.scan(":").length == 1
              m = line.match(/\A:(.*)\Z/)
              attr = Element::Blank.new
              value = parse_text_node(m[1])
            else
              m = line.match(/\A:([^:]*?):(.*)\Z/)
              attr = parse_text_node(m[1])
              value = parse_text_node(m[2])
            end

            elements << Element::Row.new(attr, value)
          elsif line.match(/\A\s*\Z/)
            elements << Element::Blank.new
          else
            elements << parse_text_node(line)
          end
        end

        Result.new(elements)
      end

      def parse_text_node(text)
        elements = text.split(/(\[\[[^\[\]]*?\]\])/).select { |s| !s.empty? }.map do |part|
          if part.match(/\A\[\[[^\[\]]*?\]\]\Z/)
            create_link_element(part)
          else
            create_text_element(part)
          end
        end

        Element::TextNode.new(elements)
      end

      def create_link_element(part)
        inner_str = part.match(/\A\[\[(.*)\]\]\Z/)[1]

        sep = inner_str.split(/ /)

        if ['http://', 'https://', 'archive://'].any?{|scheme| sep.last.start_with?(scheme) }
          link = sep.pop
          Element::Link.new(sep.join(' '), link)
        else
          Element::Link.new(sep.join(' '), nil)
        end
      end

      def create_text_element(part)
        Element::Text.new(part)
      end

      module_function :parse, :parse_text_node, :create_link_element, :create_text_element

      class Result
        attr_reader :elements

        def initialize(elements)
          @elements = elements
        end

        def ==(other)
          other.elements == elements
        end
      end

      module Element
        class Header2
          attr_reader :text_node

          def initialize(text_node)
            @text_node = text_node
          end

          def ==(other)
            other.instance_of?(self.class) && \
              other.text_node == text_node
          end
        end

        class Header1
          attr_reader :text_node

          def initialize(text_node)
            @text_node = text_node
          end

          def ==(other)
            other.instance_of?(self.class) && \
              other.text_node == text_node
          end
        end

        class List
          attr_reader :text_node

          def initialize(text_node)
            @text_node = text_node
          end

          def ==(other)
            other.instance_of?(self.class) && \
            other.text_node == text_node
          end
        end

        class Row
          attr_reader :attr_node, :value_node

          def initialize(attr_node, value_node)
            @attr_node, @value_node = attr_node, value_node
          end

          def ==(other)
            other.instance_of?(self.class) && \
              other.attr_node == attr_node && \
              other.value_node == value_node
          end
        end

        class Blank
          def initialize; end

          def ==(other)
            other.instance_of?(self.class)
          end
        end

        class TextNode
          attr_reader :text_elements

          def initialize(text_elements)
            @text_elements = text_elements
          end

          def ==(other)
            other.instance_of?(self.class) && \
              other.text_elements == text_elements
          end
        end

        class Text
          attr_reader :str

          def initialize(str)
            @str = str
          end

          def ==(other)
            other.instance_of?(self.class) && \
              other.str == str
          end
        end

        class Link
          attr_reader :str, :url

          def initialize(str, url)
            @str, @url = str, url
          end

          def ==(other)
            other.instance_of?(self.class) && \
              other.str == str && \
              other.url == url
          end
        end
      end
    end
  end
end
