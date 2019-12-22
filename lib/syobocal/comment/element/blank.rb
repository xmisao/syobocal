module Syobocal
  module Comment
    module Element
      class Blank
        def initialize; end

        def ==(other)
          other.instance_of?(self.class)
        end

        def inner_text
          ""
        end

        def self.match?(line)
          line.match(/\A\s*\Z/)
        end

        def self.parse(line)
          Element::Blank.new
        end
      end
    end
  end
end
