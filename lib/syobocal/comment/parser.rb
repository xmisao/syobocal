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

        rows = sections.find { |section| section.staff_section? }&.rows || []

        @staffs = create_staff_list(rows)
      end

      def casts
        return @casts if defined? @casts

        rows = sections.find { |section| section.cast_section? }&.rows || []

        @casts = create_cast_list(rows)
      end

      def musics
        return @musics if defined? @musics

        @musics = create_musics(all_sections)
      end

      def links
        return @links if defined? @links

        @links = sections.find { |section| section.link_section? }&.links || []
      end

      def sections
        return @sections if defined? @sections

        @sections = Section.create_sections(parse.elements)
      end

      def all_sections
        return enum_for(:all_sections) unless block_given?

        sections.each do |section|
          yield section

          section.sub_sections.each do |sub_section|
            yield sub_section
          end
        end
      end

      private

      def create_staff_list(rows)
        rows.map do |row|
          role = row.attr_node.inner_text
          people = row.value_node.split.map { |str| Person.parse(str) }

          Staff.new(role, people)
        end
      end

      def create_cast_list(rows)
        rows.map do |row|
          character = row.attr_node.inner_text
          people = row.value_node.split.map { |str| Person.parse(str) }

          Cast.new(character, people)
        end
      end

      def create_musics(sections)
        sections.each_with_object([]) do |section, musics|
          musics << section.to_music if section.music_section?
        end
      end
    end
  end
end
