module LessonsIndexer
  module Collections
    class Base
      include Enumerable

      attr_reader :list

      def initialize(list)
        @list = list
      end

      def each
        list.map { |element| yield element }
      end
    end
  end
end