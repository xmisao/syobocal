module Syobocal
  module Comment
    class Music
      attr_reader :title, :category, :data_list

      def initialize(title, category, data_list)
        @title, @category, @data_list = title, category, data_list
      end

      def ==(other)
        other.instance_of?(self.class) && other.title == title && other.category == category && other.data_list == data_list
      end
    end
  end
end
