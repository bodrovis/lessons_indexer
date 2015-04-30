module LessonsIndexer
  class Indexer
    def initialize(output, argv)
      @output, @options, @env = output, Options.new(argv), {}
    end

    def start!
      build_index
    end

    private

    def build_index
      @output.puts "Starting to build index..."
      go_to @options.path
      @env[:files] = get_files

      @env[:f_output] = open_output
      @env[:dir_name] = get_dir_name
      @env[:course_title] = @env[:dir_name].titlecase

      go_to @env[:dir_name]

      index = "# Index for the " + @env[:course_title] + " course\n\n"

      get_lessons.each do |lesson|
        index += display_lesson_link(lesson)
      end

      write_index!(index)

      @output.puts "Index for the #{@env[:course_title].titlecase} course is generated!"
      if @options.git
        @output.puts "Pushing to GitHub..."
        git_push!
      end
    end

    def write_index!(index)
      begin
        @env[:f_output].write(index)
      rescue StandardError => e
        warn e.message
      ensure
        @env[:f_output].close
      end
    end

    def display_lesson_link(lesson)
      step = lesson.match(/(\d+)(?:\.|-)(\d+)/)
      begin
        "* [Lesson #{step[1]}.#{step[2]}](#{@env[:dir_name]}/#{lesson})\n"
      rescue NoMethodError
        warn "Found the #{lesson} file which does not have proper naming. File name should contain lesson and step, for example: 'lesson3.2.md'. Skipping this file."
        return
      end
    end

    def open_output
      @env[:files].delete(@options.output)
      open(@options.output, 'w+')
    rescue StandardError => e
      warn e.message
    end

    def get_dir_name
      dir = @env[:files].first
      abort("Lesson files were not found inside the provided directory. Aborting...") if dir.nil?
      dir
    end

    def go_to(dir)
      Dir.chdir(dir)
    rescue Errno::ENOENT
      abort "The provided directory #{dir} was not found! Aborting..."
    end

    def get_files
      Dir.entries('.').delete_if {|f| f == '.' || f == '..' || f == '.git' || f == '.gitignore' }
    end

    def get_lessons
      Dir.entries('.').keep_if {|f| f =~ /\.md\z/i }
    end

    def git_push!
      `git add .`
      `git commit -am "Added index"`
      `git push origin HEAD`
    end
  end
end