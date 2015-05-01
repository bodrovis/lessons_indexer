module LessonsIndexer
  class Starter
    attr_reader :output, :options

    def initialize(output, argv)
      @output, @options = output, Options.new(argv)
    end

    def start!
      indexer = Indexer.new(output, options)

      within options.path do
        if options.all
          git = GitManager::Brancher.new
          git.get_branches.each do |branch|
            git.within_branch branch do
              indexer.build_index!
            end
          end
        else
          indexer.build_index!
        end
      end
    end
  end
end