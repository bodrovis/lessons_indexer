module LessonsIndexer
  class Writer
    attr_accessor :file

    def initialize(name)
      @file = File.open(name, 'w+')
    end

    def <<(*args)
      begin
        file.write(args.join)
      rescue StandardError => e
        warn e.message
      ensure
        file.close
      end
    end
  end
end