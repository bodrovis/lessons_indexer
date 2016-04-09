module LessonsIndexer
  class Starter < Messenger
    attr_reader :options

    def initialize(argv)
      @options = Options.new(argv)
    end

    def start!
      with_messages(pou('starter.welcome', version: LessonsIndexer::VERSION), pou('starter.done'), false) do
        indexer = Indexer.new(options)

        within options.path do
          if options.all
            brancher = GitManager::Brancher.new
            brancher.get_branches.each do |branch|
              brancher.within_branch branch do
                indexer.do_work!
              end
            end
          else
            indexer.do_work!
          end
        end
      end
    end
  end
end