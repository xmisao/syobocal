module Syobocal
  module Comment
    module Element
      class TextNode
        attr_reader :text_elements

        SUBJECT_SEPARATOR = "、"
        ENCODED_SEPARATOR = "\t"

        def initialize(text_elements)
          @text_elements = text_elements
        end

        def inner_text
          text_elements.map(&:str).join("")
        end

        def ==(other)
          other.instance_of?(self.class) && other.text_elements == text_elements
        end

        def split
          buffer = ""

          text_elements.each do |node|
            case node
            when Element::Text
              buffer << node.str.gsub(SUBJECT_SEPARATOR, ENCODED_SEPARATOR)
            when Element::Link
              buffer << node.str
            end
          end

          buffer.scan(/[^#{ENCODED_SEPARATOR}\(]+(?:\(.*?\))?/).map { |str| str.gsub(ENCODED_SEPARATOR, SUBJECT_SEPARATOR).strip }
        end

        def self.match?(line)
          true
        end

        def self.parse(text)
          elements = text.split(/(\[\[[^\[\]]*?\]\])/).select { |s| !s.empty? }.map do |s|
            if s.match(/\A\[\[[^\[\]]*?\]\]\Z/)
              Link.create(s)
            else
              Text.create(s)
            end
          end

          Element::TextNode.new(elements)
        end
      end
    end
  end
end
