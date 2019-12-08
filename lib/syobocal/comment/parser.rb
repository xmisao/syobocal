module Syobocal
  module Comment
    module Parser
      def parse(str)
        return Result.new([]) unless str

        elements = []

        str.each_line do |line|
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
              attr = ""
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
        text.split(/(\[\[[^\[\]]*?\]\])/).select { |s| !s.empty? }.map do |part|
          if part.match(/\A\[\[[^\[\]]*?\]\]\Z/)
            create_link_element(part)
          else
            create_text_element(part)
          end
        end
      end

      def create_link_element(part)
        inner_str = part.match(/\A\[\[(.*)\]\]\Z/)[1]

        sep = inner_str.split(/ /)

        if sep.length == 1
          Element::Link.new(sep.first, nil)
        else
          str = sep[0..-2].join
          link = sep[-1]
          Element::Link.new(str, link)
        end
      end

      def create_text_element(part)
        Element::Text.new(part)
      end

      module_function :parse, :parse_text_node, :create_link_element, :create_text_element

      class Result
        def initialize(elements)
          @elements = elements
        end
      end

      module Element
        class Header2
          def initialize(text_node)
            @text_node = text_node
          end
        end

        class Header1
          def initialize(text_node)
            @text_node = text_node
          end
        end

        class List
          def initialize(text_node)
            @text_node = text_node
          end
        end

        class Row
          def initialize(attr_node, value_node)
            @attr_node, @value_node = attr_node, value_node
          end
        end

        class Blank
          def initialize; end
        end

        class TextNode
          def initialize(text_elements)
            @text_elements = text_elements
          end
        end

        class Text
          def initialize(str)
            @str = str
          end
        end

        class Link
          def initialize(str, url)
            @str, @url = str, url
          end
        end
      end
    end
  end
end
