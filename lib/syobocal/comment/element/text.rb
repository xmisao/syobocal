module Syobocal
  module Comment
    module Element
      class Text
        attr_reader :str

        def initialize(str)
          @str = str
        end

        def ==(other)
          other.instance_of?(self.class) && other.str == str
        end

        def self.create(text)
          new(text)
        end
      end
    end
  end
end
