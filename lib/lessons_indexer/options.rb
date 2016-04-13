module LessonsIndexer
  class Options < Messenger
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
        Slop.parse argv do |o|
          o.string '-p', '--path', pou('options.path'), default: pou('options.default.path')
          o.bool '-s', '--skip_index', pou('options.skip_index'), default: false
          o.string '-o', '--output', pou('options.output'), default: pou('options.default.output')
          o.bool '-g', '--git', pou('options.git'), default: false
          o.string '-m', '--message', pou('options.message'), default: pou('options.default.message')
          o.bool '-a', '--all', pou('options.all'), default: false
          o.bool '-i', '--headings', pou('options.headings'), default: false
          o.string '-d', '--headings_dir', pou('options.headings_dir'), default: pou('options.default.headings_dir')
          o.bool '-f', '--pdf', pou('options.pdf'), default: false
          o.array '-l', '--lessons', pou('options.lessons'), default: []
          o.on '--help' do
            puts o
            exit
          end
        end.to_hash
      rescue Slop::Error => e
        exit_msg e.message
      end
    end
  end
end