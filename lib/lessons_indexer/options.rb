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
      return defaults if argv.empty?

      begin
        options = Slop.parse(argv, strict: true, help: true,
                             banner: 'Welcome to Lessons Indexer. Here is the list of available options:') do
          on '-p', '--path', 'Path', as: String, argument: true
          on '-o', '--output', 'Output file', as: String, argument: true
          on '-g', '--git', 'Push changes to the remote Git branch?'
          on '-m', '--message', 'Commit message', as: String, argument: true
          on '-a', '--all', 'Rebuild indexes in all branches (except master)'
        end.to_hash
        normalize! options
      rescue Slop::Error => e
        abort e.message
        defaults
      end
    end

    def defaults
      {path: '.', output: 'README.md', git: false, message: 'Added index', all: false}
    end

    def normalize!(opts)
      opts.merge!(defaults) {|k, v1, v2| v1.nil? ? v2 : v1}
    end
  end
end