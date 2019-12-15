module Syobocal
  module Comment
    module Element
      class TextNode
        attr_reader :text_elements

        def initialize(text_elements)
          @text_elements = text_elements
        end

        def inner_text
          text_elements.map(&:str).join("")
        end

        def ==(other)
          other.instance_of?(self.class) && other.text_elements == text_elements
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
