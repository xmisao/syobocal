module Syobocal
  module Comment
    module Element
      class Root
        attr_reader :elements

        def initialize(elements)
          @elements = elements
        end

        def ==(other)
          other.elements == elements
        end
      end
    end
  end
end
