module LessonsIndexer
  class Course
    include Models
    include Collections

    attr_reader :dir, :headings_dir, :title, :lessons, :headings

    def initialize(course_dir, headings_dir)
      @dir = course_dir
      @headings_dir = headings_dir
      @title = dir.gsub(/_handouts\z/i, '').titlecase
      @headings = []
    end

    def generate_index
      lessons.list.sort.inject("# Index for the " + title + " course\n\n") do |memo, lesson|
        memo + lesson.link(dir)
      end
    end

    def generate_headings
      lessons.each do |lesson|
        lesson_heading = headings.for(lesson)
        if lesson_heading
          yield "![](#{headings_dir}/#{lesson_heading.file_name})\n\n", lesson.path
        else
          warning "I was not able to find heading image for the #{lesson.name}"
        end
      end
    end

    def generate_pdfs
      within(dir, true) do
        lessons.list.sort.first(2).each do |lesson|
          %x{pandoc #{lesson.file_name} -f markdown_github -o #{lesson.file_name.gsub(/md\z/i, '')}.pdf --variable geometry:"top=1.5cm, bottom=2.5cm, left=1.5cm, right=1.5cm" --latex-engine=xelatex --variable mainfont="Open Sans" --variable monofont="Liberation Mono" --variable fontsize="12pt"}
        end
      end
    end

    def load_headings!
      within(dir + '/' + headings_dir, true) do
        @headings = HeadingsList.new(all_with_pattern(Heading::VERSION_PATTERN).map {|heading| Heading.new(heading)})
      end
    end

    def load_lessons!
      within(dir, true) do
        @lessons = LessonsList.new(all_with_pattern(Lesson::NAME_PATTERN).map {|lesson| Lesson.new(lesson)})
      end
    end

    private

    def all_with_pattern(pattern)
      Dir.entries('.').keep_if {|f| f =~ pattern }
    end
  end
end