module LessonsIndexer
  module Collections
    class HeadingsList < Base
      def for(lesson)
        detect do |heading|
          lesson.major == heading.major && lesson.minor == heading.minor
        end
      end
    end
  end
end