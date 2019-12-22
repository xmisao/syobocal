module Syobocal
  module Comment
    class Cast
      attr_reader :character, :people

      def initialize(character, people)
        @character, @people = character, people
      end

      def ==(other)
        other.instance_of?(self.class) && other.character == character && other.people == people
      end
    end
  end
end
