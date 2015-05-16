module LessonsIndexer
  class Starter
    include Addons::GitManager
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
                work_with indexer
              end
            end
          else
            work_with indexer
          end
        end
      end
    end

    private

    def work_with(indexer)
      indexer.do_work!
      git_push! if options.git
    end

    def git_push!
      pusher = GitManager::Pusher.new(options.message)
      pusher.push!
    end
  end
end