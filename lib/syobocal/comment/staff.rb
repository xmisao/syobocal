module Syobocal
  module Comment
    class Staff
      attr_reader :role, :people

      def initialize(role, people)
        @role, @people = role, people
      end

      def ==(other)
        other.instance_of?(self.class) && other.role == role && other.people == people
      end
    end
  end
end
