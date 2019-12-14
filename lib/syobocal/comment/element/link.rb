module Syobocal
  module Comment
    module Element
      class Link
        attr_reader :str, :url

        def initialize(str, url)
          @str, @url = str, url
        end

        def ==(other)
          other.instance_of?(self.class) && other.str == str && other.url == url
        end

        def self.create(text)
          inner_str = text.match(/\A\[\[(.*)\]\]\Z/)[1]

          sep = inner_str.split(/ /)

          if ["http://", "https://", "archive://"].any? { |scheme| sep.last.start_with?(scheme) }
            link = sep.pop
            new(sep.join(" "), link)
          else
            new(sep.join(" "), nil)
          end
        end
      end
    end
  end
end
