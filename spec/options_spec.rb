module LessonsIndexer
  RSpec.describe Options do
    let(:argv) { Array.new }

    it "should assign default options if no arguments are given" do
      options = Options.new(argv)
      expect(options.path).to eq('.')
      expect(options.output).to eq('README.md')
      expect(options.git).to be_falsey
      expect(options.message).to eq('Added index')
      expect(options.all).to be_falsey
      expect(options.headings).to be_falsey
      expect(options.headings_dir).to eq('headers')
    end

    it "should allow to override some options" do
      argv = ['-p', 'test_path', '-g', '-o', 'test.md']
      options = Options.new(argv)
      expect(options.path).to eq('test_path')
      expect(options.output).to eq('test.md')
      expect(options.git).to be_truthy
      expect(options.message).to eq('Added index')
      expect(options.all).to be_falsey
      expect(options.headings).to be_falsey
    end
  end
end