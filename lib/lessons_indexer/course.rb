module LessonsIndexer
  class Course
    STEP_LESSON_PATTERN = /(\d+)(?:\.|-)(\d+)/

    attr_reader :dir, :title, :lessons

    def initialize(course_dir)
      @dir = course_dir
      @title = dir.gsub(/_handouts\z/i, '').titlecase
      @lessons = get_lessons
    end

    def get_lessons
      #TODO: Lesson class
      within(dir, true) do
        Dir.entries('.').keep_if {|f| f =~ /\.md\z/i }.sort do |a, b|
          begin
            step_a, step_b = a.match(STEP_LESSON_PATTERN), b.match(STEP_LESSON_PATTERN)
            major_a, minor_a, major_b, minor_b = step_a[1].to_i, step_a[2].to_i, step_b[1].to_i, step_b[2].to_i
            if major_a == major_b
              minor_a <=> minor_b
            else
              major_a <=> major_b
            end
          rescue NoMethodError
            warning "Found the #{lesson} file which does not have proper naming. File name should contain lesson and step, for example: 'lesson3.2.md'. Skipping this file."
          end
        end
      end
    end
  end
end