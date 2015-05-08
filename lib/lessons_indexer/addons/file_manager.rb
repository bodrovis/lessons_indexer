module LessonsIndexer
  class Writer
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def prepend_data(data)
      begin
        old_data = File.read(name)
      rescue StandardError => e
        warning e.message
      end
      unless old_data.start_with?(data)
        new_data = old_data.prepend(data)
        self << new_data
      end
    end

    def <<(*args)
      begin
        file = File.open(name, 'w+')
        file.write(args.join)
      rescue StandardError => e
        warning e.message
      ensure
        file.close if file && !file.closed?
      end
    end
  end
end