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
        File.open(name, 'w+') { |f| f.write(args.join) }
      rescue StandardError => e
        warning e.message
      end
    end
  end
end