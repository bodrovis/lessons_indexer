module LessonsIndexer
  class Indexer
    include Addons::FileManager
    include Addons::GitManager

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def do_work!
      course = Course.new(get_course_dir, options.headings_dir)

      build_index(course) unless options.skip_index
      add_headings(course) if options.headings
      git_push! if options.git
    end

    def build_index(course)
      course.load_lessons!
      with_messages("Starting to build index...", "Index for the #{course.title} course is generated!") do
        write! course.generate_index, options.output
      end
    end

    def add_headings(course)
      course.load_lessons!
      course.load_headings!
      with_messages("Starting to add headings...", "Headings for the lesson files of #{course.title} course were added!") do
        course.generate_headings { |heading_line, lesson_file| prepend!(heading_line, lesson_file) }
      end
    end

    def get_course_dir
      dir = Dir.entries('.').detect {|el| el =~ /_handouts\z/i}
      exit_msg("Lesson files were not found inside the provided directory. Aborting...") if dir.nil?
      dir
    end

    private

    def write!(contents, file)
      writer = Writer.new(file)
      writer << contents
    end

    def prepend!(contents, file)
      writer = Writer.new(file)
      writer.prepend_data(contents)
    end

    def git_push!
      pusher = Pusher.new(options.message)
      pusher.push!
    end
  end
end