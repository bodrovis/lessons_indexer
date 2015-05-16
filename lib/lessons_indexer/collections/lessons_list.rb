module LessonsIndexer
  module Collections
    class LessonsList
      include Enumerable

      attr_reader :list

      def initialize(list)
        @list = list
      end

      def each
        list.map { |lesson| yield lesson }
      end
    end
  end
end