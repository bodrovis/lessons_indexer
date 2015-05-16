module LessonsIndexer
  module Models
    class Base
      include Comparable

      VERSION_PATTERN = /(?<minor_major>(?<major>(\d+))(?:\.|-)(?<minor>(\d+)))/i
      attr_reader :file_name, :major, :minor, :path

      def initialize(file_name)
        @file_name = file_name
        @path = File.expand_path(file_name)
        @major = file_name.match(VERSION_PATTERN)[:major].to_i
        @minor = file_name.match(VERSION_PATTERN)[:minor].to_i
      end

      def <=>(other)
        if self.major == other.major
          self.minor <=> other.minor
        else
          self.major <=> other.major
        end
      end
    end
  end
end