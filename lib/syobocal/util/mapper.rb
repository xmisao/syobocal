module Syoboi
  module Util
    module Mapper
      module ElementsMapper
        def map(elm)
          result = {}
          elm.each_element{|child|
            set(result, to_snake(child.name).to_sym, child, @map[child.name]) 
          }
          result
        end

        def to_snake(name)
          name.gsub(/([a-z])([A-Z])/){ $1 + '_' + $2 }.downcase
        end

        def set(hash, key, elm, type)
          if elm
            val = nil
            if elm.text
              case type
              when :str
                val = elm.text
              when :int
                val = elm.text.to_i
              when :time
                val = Time.parse(elm.text)
              else
                raise "Undefined mapping for #{key}" if $SYOBOI_OPTION_STRICT
                val = elm.text
              end
            end
            hash[key] = val
          end
        end
      end
    end
  end
end
