module Syobocal
  module SubTitles
    class SubTitle
      attr_reader :episode, :title

      def initialize(episode, title)
        @episode, @title = episode, title
      end

      def ==(other)
        other.instance_of?(self.class) && other.episode == episode && other.title == title
      end
    end
  end
end
