module LessonsIndexer
  module GitManager
    class Pusher
      attr_reader :message

      def initialize(message)
        @message = message
      end

      def push!
        %x{git add .}
        %x{git commit -am "#{message}"}
        %x{git push origin HEAD}
      end
    end

    class Brancher
      attr_reader :ignore_master

      def initialize(ignore_master = true)
        @ignore_master = ignore_master
      end

      def get_branches
        branches = %x{git branch}.split("\n").map {|br| br.strip.gsub(/\A\*\s*/, '') }
        ignore_master ? branches.reject {|el| el == 'master'} : branches
      end

      def within_branch(branch)
        %x{git checkout #{branch} --force}
        yield if block_given?
      end
    end
  end
end