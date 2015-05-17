module LessonsIndexer
  class Starter
    attr_reader :options

    def initialize(argv)
      @options = Options.new(argv)
    end

    def start!
      with_messages("=== [ Welcome to Lessons Indexer ver#{LessonsIndexer::VERSION}! ] ===", "=== [ DONE. ] ===", false) do
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