module LessonsIndexer
  module Collections
    class HeadingsList
      include Enumerable

      attr_reader :list

      def initialize(list)
        @list = list
      end

      def for(lesson)
        detect do |heading|
          lesson.major == heading.major && lesson.minor == heading.minor
        end
      end

      def each
        list.map { |heading| yield heading }
      end
    end
  end
end