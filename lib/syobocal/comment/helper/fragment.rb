module Syobocal
  module Comment
    module Helper
      class Fragment
        CHILD_BEGIN = "("
        CHILD_END = ")"
        SEPARATOR = "、"

        attr_reader :text, :child, :following

        def initialize(text, child, following)
          @text, @child, @following = text, child, following
        end

        def self.parse(str)
          chars = str.each_char.to_a

          parse_chars(chars)
        end

        def self.parse_chars(chars)
          text = ""
          child = nil
          following = nil

          until chars.empty?
            c = chars.shift

            case c
            when CHILD_BEGIN
              child = parse_chars(chars)
            when CHILD_END
              return Fragment.new(text, child, following)
            when SEPARATOR
              following = parse_chars(chars)
            else
              text << c
            end
          end

          Fragment.new(text, child, following)
        end

        def pretty_output(level = 0)
          line = level.times.map { " " }.join

          line << text

          puts line

          child&.pretty_output(level + 1)

          following&.pretty_output(level)
        end

        def to_a
          array = [self]
          target = self

          while target.following
            array << target.following
            target = target.following
          end

          array
        end

        def to_s
          to_a.map { |f|
            if f.child
              "#{f.text}(#{f.child.to_s})"
            else
              "#{f.text}"
            end
          }.join(SEPARATOR)
        end
      end
    end
  end
end
