module Syobocal
  module Comment
    class MusicData
      attr_reader :attr, :attr_text, :attr_note, :value, :people

      def initialize(attr, attr_text, attr_note, value, people)
        @attr, @attr_text, @attr_note, @value, @people = attr, attr_text, attr_note, value, people
      end

      def ==(other)
        other.instance_of?(self.class) && other.attr == attr && other.attr_text == attr_text && other.attr_note == other.attr_note && other.value == value && other.people == people
      end
    end
  end
end
