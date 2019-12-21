module Syobocal
  module Comment
    class Section
      attr_reader :header, :elements, :sub_sections

      class RestrictedOperation < StandardError; end

      def initialize(header, elements)
        @header, @elements = header, elements
        @sub_sections = []
      end

      def sub_section?
        @header.instance_of? Element::Header2
      end

      def add_subsection(sub_section)
        raise RestrictedOperation if sub_section?
        raise RestrictedOperation unless sub_section.sub_section?

        @sub_sections << sub_section
      end

      STAFF_WORD = "スタッフ"
      CAST_WORD = "キャスト"
      LINK_WORD = "リンク"
      MUSIC_WORDS = %w(テーマ ソング 歌 曲)
      MUSIC_TITLE_REGEXP = /「(.+)」/

      def staff_section?
        header.text_node.inner_text.include?(STAFF_WORD)
      end

      def cast_section?
        header.text_node.inner_text.include?(CAST_WORD)
      end

      def link_section?
        header.text_node.inner_text.include?(LINK_WORD)
      end

      def music_section?
        str = header.text_node.inner_text

        MUSIC_WORDS.any? { |keyword| str.include?(keyword) } && str.match(MUSIC_TITLE_REGEXP)
      end

      def to_music
        title = header.text_node.inner_text.match(MUSIC_TITLE_REGEXP)[1]
        category = header.text_node.inner_text.sub(MUSIC_TITLE_REGEXP, "")

        data_list = rows.map do |row|
          attr = row.attr_node.inner_text
          value = row.value_node.inner_text
          MusicData.new(attr, value)
        end

        Music.new(title, category, data_list)
      end

      def rows
        elements.select { |element| element.is_a? Element::Row }
      end

      def links
        elements.each_with_object([]) { |element, links|
          case element
          when Element::List
            links << element.text_node.text_elements.select { |elm| elm.instance_of? Element::Link }
          when Element::TextNode
            links << element.text_elements.select { |elm| elm.instance_of? Element::Link }
          end
        }.flatten
      end

      def self.create_sections(elements)
        sections = []
        current_header = nil
        buffered_elements = []

        elements.each do |element|
          case element
          when Element::Header1, Element::Header2
            if current_header
              sections << Section.new(current_header, buffered_elements)
              buffered_elements = []
            end

            current_header = element
          else
            buffered_elements << element if current_header
          end
        end

        if current_header
          sections << Section.new(current_header, buffered_elements)
        end

        structure_sections(sections)
      end

      def self.structure_sections(sections)
        root_sections = []
        parent_section = nil

        sections.each do |section|
          if section.sub_section?
            parent_section.add_subsection(section)
          else
            root_sections << section
            parent_section = section
          end
        end

        root_sections
      end

      private_class_method :structure_sections
    end
  end
end
