module LessonsIndexer
  class Course < Messenger
    include Models
    include Collections

    attr_reader :dir, :headings_dir, :title, :lessons, :headings

    def initialize(course_dir, headings_dir)
      @dir = course_dir
      @headings_dir = headings_dir
      @title = dir.gsub(/_handouts\z/i, '').titlecase
    end

    def generate_files(lessons_count)
      within(dir, true) do
        lessons_count.map {|l| Integer(l)}.each_with_index do |steps, lesson|
          (1..steps).each do |step|
            File.new("lesson#{lesson + 1}-#{step}.md", 'w+').close
          end
        end
      end
    end

    def generate_index
      lessons.list.sort.inject(pou('course.index_title', title: title)) do |memo, lesson|
        memo + lesson.link(dir)
      end
    end

    def generate_headings
      lessons.each do |lesson|
        lesson_heading = headings.for(lesson)
        if lesson_heading
          yield "![](#{headings_dir}/#{lesson_heading.file_name})\n\n", lesson.path
        else
          warning pou('warnings.heading_not_found', lesson: lesson.name)
        end
      end
    end

    def generate_pdfs
      within(dir, true) do
        lessons.list.sort.each do |lesson|
          %x{pandoc #{lesson.file_name} -f markdown_github -o #{lesson.file_name.gsub(/md\z/i, '')}pdf --variable geometry:"top=1.5cm, bottom=2.5cm, left=1.5cm, right=1.5cm" --latex-engine=xelatex --variable mainfont="Open Sans" --variable monofont="Liberation Mono" --variable fontsize="12pt"}
        end
      end
    end

    def load_headings!
      within(dir + '/' + headings_dir, true) do
        @headings ||= HeadingsList.new(all_with_pattern(Heading::VERSION_PATTERN).map {|heading| Heading.new(heading)})
      end
    end

    def load_lessons!
      within(dir, true) do
        @lessons ||= LessonsList.new(all_with_pattern(Lesson::NAME_PATTERN).map {|lesson| Lesson.new(lesson)})
      end
    end

    private

    def all_with_pattern(pattern)
      Dir.entries('.').keep_if {|f| f =~ pattern }
    end
  end
end