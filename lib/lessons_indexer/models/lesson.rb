module LessonsIndexer
  module Models
    class Lesson < Base
      NAME_PATTERN = /(?<minor_major>(?<major>(\d+))(?:\.|-)(?<minor>(\d+)))(?<ext>\.md)/i
      attr_reader :name

      def initialize(file_name)
        super file_name
        @name = file_name.gsub(NAME_PATTERN, ' \k<minor_major>').titlecase
      end

      def link(dir)
        "* [#{name}](#{dir}/#{file_name})\n"
      end
    end
  end
end