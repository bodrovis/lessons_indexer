module LessonsIndexer
  class Indexer < Messenger
    include Addons::FileManager
    include Addons::GitManager

    attr_reader :options

    def initialize(options)
      @options = options
    end

    def do_work!
      course = Course.new(get_course_dir, options.headings_dir)

      if options.lessons.length > 0
        generate_files(course)
      else
        build_index(course) unless options.skip_index
        add_headings(course) if options.headings
        generate_pdfs(course) if options.pdf
        git_push! if options.git
      end
    end

    def generate_files(course)
      with_messages(pou('lessons.starting'), pou('lessons.done', title: course.title)) do
        course.generate_files(options.lessons)
      end
    end

    def build_index(course)
      course.load_lessons!
      with_messages(pou('index.starting'), pou('index.done', title: course.title)) do
        write! course.generate_index, options.output
      end
    end

    def add_headings(course)
      course.load_lessons!
      course.load_headings!
      with_messages(pou('heading.starting'), pou('heading.done', title: course.title)) do
        course.generate_headings { |heading_line, lesson_file| prepend!(heading_line, lesson_file) }
      end
    end

    def generate_pdfs(course)
      course.load_lessons!
      with_messages(pou('pdf.starting'), pou('pdf.done', title: course.title)) do
        course.generate_pdfs
      end
    end

    def get_course_dir
      dir = Dir.entries('.').detect {|el| el =~ /_handouts\z/i}
      exit_msg(pou('errors.files_not_found')) if dir.nil?
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