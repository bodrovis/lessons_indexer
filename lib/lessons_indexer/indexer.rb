module LessonsIndexer
  class Indexer
    attr_reader :output, :options

    def initialize(output, options)
      @output, @options = output, options
    end

    def build_index!
      output.puts "Starting to build index..."
      output.puts "Index for the #{save_index} course is generated!"
      output.puts "=" * 50
    end

    private

    def save_index
      dir_name = get_dir_name
      course = course_title(dir_name)

      generate_index_for course, dir_name

      git_push! if options.git
      course
    end

    def generate_index_for(course, dir)
      write!(within(dir, true) do
               get_lessons.inject("# Index for the " + course + " course\n\n") do |memo, lesson|
                 memo + display_lesson_link(lesson, dir)
               end
             end)
    end

    def display_lesson_link(lesson, dir)
      step = lesson.match(/(\d+)(?:\.|-)(\d+)/)
      begin
        "* [Lesson #{step[1]}.#{step[2]}](#{dir}/#{lesson})\n"
      rescue NoMethodError
        warn "Found the #{lesson} file which does not have proper naming. File name should contain lesson and step, for example: 'lesson3.2.md'. Skipping this file."
        return ''
      end
    end

    def get_dir_name
      dir = get_files.detect {|el| el =~ /_handouts\z/i}
      abort("Lesson files were not found inside the provided directory. Aborting...") if dir.nil?
      dir
    end

    def get_files
      Dir.entries('.').delete_if {|f| f == '.' || f == '..' || f == '.git' || f == '.gitignore' }
    end

    def get_lessons
      Dir.entries('.').keep_if {|f| f =~ /\.md\z/i }
    end

    def course_title(dir_name)
      dir_name.gsub(/_handouts\z/i, '').titlecase
    end

    def git_push!
      pusher = GitManager::Pusher.new(options.message)
      pusher.push!
    end

    def write!(index)
      writer = Writer.new(options.output)
      writer << index
    end
  end
end