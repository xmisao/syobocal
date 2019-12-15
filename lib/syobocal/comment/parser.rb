module Syobocal
  module Comment
    class Parser
      ELEMENT_CLASSES = [
        Element::Header2,
        Element::Header1,
        Element::List,
        Element::Row,
        Element::Blank,
        Element::TextNode, # NOTE Sentinel
      ]

      STAFF_WORD = "スタッフ"
      CAST_WORD = "キャスト"
      LINK_WORD = "リンク"
      PERSON_SEPARATOR = "、"
      MUSIC_WORDS = %w(テーマ ソング 歌 曲)
      MUSIC_TITLE_REGEXP = /「(.+)」/

      def initialize(comment)
        @comment = comment
      end

      def parse
        return @parse if defined? @parse

        return @parse = Element::Root.new([]) unless @comment

        elements = @comment.each_line.map do |line|
          line.chomp!
          ELEMENT_CLASSES.find { |clazz| clazz.match?(line) }.parse(line)
        end

        @parse = Element::Root.new(elements)
      end

      def staffs
        return @staffs if defined? @staffs

        rows = extract_section_rows(STAFF_WORD)

        @staffs = create_staff_list(rows)
      end

      def casts
        return @casts if defined? @casts

        rows = extract_section_rows(CAST_WORD)

        @casts = create_cast_list(rows)
      end

      def musics
        return @musics if defined? @musics

        @musics = extract_musics
      end

      def links
        return @links if defined? @links

        @links = extract_section_links(LINK_WORD)
      end

      private

      def extract_section_rows(keyword)
        target_section = false
        rows = []

        parse.elements.each do |element|
          if target_section
            case element
            when Element::Header1, Element::Header2
              break
            when Element::Row
              rows << element
            end
          else
            if element.is_a?(Element::Header1) && element.text_node.inner_text.include?(keyword)
              target_section = true
            end
          end
        end

        rows
      end

      def extract_section_links(keyword)
        target_section = false
        links = []

        parse.elements.each do |element|
          if target_section
            case element
            when Element::Header1, Element::Header2
              break
            when Element::List
              links << element.text_node.text_elements.select { |elm| elm.instance_of? Element::Link }
            when Element::TextNode
              links << element.text_elements.select { |elm| elm.instance_of? Element::Link }
            end
          else
            if element.is_a?(Element::Header1) && element.text_node.inner_text.include?(keyword)
              target_section = true
            end
          end
        end

        links.flatten
      end

      def create_staff_list(rows)
        rows.map do |row|
          role = row.attr_node.inner_text
          people = parse_people(row.value_node.inner_text)

          Staff.new(role, people)
        end
      end

      def create_cast_list(rows)
        rows.map do |row|
          charactor = row.attr_node.inner_text
          people = parse_people(row.value_node.inner_text)

          Cast.new(charactor, people)
        end
      end

      def parse_people(people_str)
        scan_result = people_str.scan(/[^#{PERSON_SEPARATOR}\(]+(?:\(.*?\))?/)

        scan_result.map do |part|
          _, name, note = *(part.match(/\A([^\(\)]+?)(?:\((.*?)\))?\Z/).to_a)

          Person.new(name, note)
        end
      end

      def extract_musics
        section_header = nil
        buffered_rows = []
        music_sections = []
        musics = []

        parse.elements.each do |element|
          if section_header
            case element
            when Element::Header1, Element::Header2
              musics << create_music(section_header, buffered_rows)

              section_header = nil
              buffered_rows = []

              if music_section?(element.text_node.inner_text)
                section_header = element
              end
            when Element::Row
              buffered_rows << element
            end
          else
            if (element.is_a?(Element::Header1) || element.is_a?(Element::Header2)) && music_section?(element.text_node.inner_text)
              section_header = element
            end
          end
        end

        if section_header
          musics << create_music(section_header, buffered_rows)
        end

        musics
      end

      def music_section?(str)
        MUSIC_WORDS.any? { |keyword| str.include?(keyword) } && str.match(MUSIC_TITLE_REGEXP)
      end

      def create_music(header, rows)
        title = header.text_node.inner_text.match(MUSIC_TITLE_REGEXP)[1]
        category = header.text_node.inner_text.sub(MUSIC_TITLE_REGEXP, "")

        data_list = rows.map do |row|
          attr = row.attr_node.inner_text
          value = row.value_node.inner_text
          MusicData.new(attr, value)
        end

        Music.new(title, category, data_list)
      end
    end
  end
end
