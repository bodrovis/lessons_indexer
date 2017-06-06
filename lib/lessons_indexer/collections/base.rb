module LessonsIndexer
  module Collections
    class Base
      include Enumerable

      attr_reader :list

      def initialize(list)
        @list = list
      end

      def each
        list.each { |element| yield element }
      end
    end
  end
end