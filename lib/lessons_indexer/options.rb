module LessonsIndexer
  class Options
    def initialize(argv)
      parse_args(argv).each do |k, v|
        # attr_accessor for each possible option
        self.class.class_eval do
          attr_accessor k
        end

        # setting each option as instance variable
        self.instance_variable_set "@#{k}", v
      end
    end

    private

    def parse_args(argv)
      begin
        Slop.parse(argv, strict: true, help: true,
                             banner: 'Welcome to Lessons Indexer. Here is the list of available options:') do |o|
          o.string '-p', '--path', 'Path to the directory with the course', default: '.'
          o.bool '-s', '--skip_index', 'Skip index generation for the course', default: false
          o.string '-o', '--output', 'Output file', default: 'README.md'
          o.bool '-g', '--git', 'Push changes to the remote Git branch?', default: false
          o.string '-m', '--message', 'Commit message', default: 'Added index'
          o.bool '-a', '--all', 'Work with all branches (except for master)', default: false
          o.bool '-i', '--headings', 'Add heading images to the beginning of the lesson files?', default: false
          o.string '-d', '--headings_dir', 'Relative path to the directory with heading images', default: 'headers'
        end.to_hash
      rescue Slop::Error => e
        exit_msg e.message
      end
    end
  end
end