module Syobocal
  module Comment
    class MusicData
      attr_reader :attr, :value

      def initialize(attr, value)
        @attr, @value = attr, value
      end

      def ==(other)
        other.instance_of?(self.class) && other.attr == attr && other.value == value
      end
    end
  end
end
