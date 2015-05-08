module LessonsIndexer
  class Indexer
    STEP_LESSON_PATTERN = /(\d+)(?:\.|-)(\d+)/

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def build_index!
      course_dir_name = get_dir_name
      course = course_title(course_dir_name)

      with_messages("Starting to build index...", "Index for the #{course} course is generated!") do
        generate_index_for course, course_dir_name
      end
    end

    def add_headings!
      with_messages("Starting to add headings...", "Headings for the lesson files were added!") do
        within(get_dir_name, true) do
          generate_headings_for options.headings_dir
        end
      end
    end

    private

    def generate_headings_for(dir)
      images = within(dir, true) { get_files }.keep_if {|f| f.match(STEP_LESSON_PATTERN)}

      get_lessons.each do |lesson_file|
        step_lesson = lesson_file.match(STEP_LESSON_PATTERN)
        begin
          lesson_image = images.detect do |image|
            step_image = image.match(STEP_LESSON_PATTERN)
            step_lesson[1] == step_image[1] && step_lesson[2] == step_image[2]
          end
          if lesson_image
            prepend!("![](#{dir}/#{lesson_image})\n\n", lesson_file)
          else
            warning "I was not able to find heading image for the lesson #{step_lesson[0]}"
          end
        rescue NoMethodError
          warning "Found the #{lesson_file} file which does not have proper naming. File name should contain lesson and step, for example: 'lesson3.2.md'. Skipping this file."
        end
      end
    end

    def generate_index_for(course, dir)
      write!(within(dir, true) do
               get_lessons.inject("# Index for the " + course + " course\n\n") do |memo, lesson|
                 memo + display_lesson_link(lesson, dir)
               end
             end, options.output)
    end

    def display_lesson_link(lesson, dir)
      step = lesson.match(STEP_LESSON_PATTERN)
      begin
        "* [Lesson #{step[1]}.#{step[2]}](#{dir}/#{lesson})\n"
      rescue NoMethodError
        warning "Found the #{lesson} file which does not have proper naming. File name should contain lesson and step, for example: 'lesson3.2.md'. Skipping this file."
        return ''
      end
    end

    def get_dir_name
      dir = get_files.detect {|el| el =~ /_handouts\z/i}
      exit_msg("Lesson files were not found inside the provided directory. Aborting...") if dir.nil?
      dir
    end

    def get_files
      Dir.entries('.').delete_if {|f| f == '.' || f == '..' || f == '.git' || f == '.gitignore' }
    end

    def get_lessons
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

    def course_title(dir_name)
      dir_name.gsub(/_handouts\z/i, '').titlecase
    end

    def write!(contents, file)
      writer = Writer.new(file)
      writer << contents
    end

    def prepend!(contents, file)
      writer = Writer.new(file)
      writer.prepend_data(contents)
    end
  end
end