module Syobocal
  module Comment
    class Person
      PERSON_SEPARATOR = "、"
      ENCODED_SEPARATOR = "\t"

      attr_reader :name, :note

      def initialize(name, note)
        @name, @note = name, note
      end

      def ==(other)
        other.instance_of?(self.class) && other.name == name && other.note == note
      end

      def self.parse(str)
        _, name, note = *(str.match(/\A([^\(\)]+?)(?:\((.*?)\))?\Z/).to_a)

        Person.new(name, note)
      end

      def self.multi_parse(str)
        Helper::Fragment.parse(str).to_a.map{|f|
          name = f.text
          note = f&.child&.to_s

          Person.new(name, note)
        }
      end
    end
  end
end
