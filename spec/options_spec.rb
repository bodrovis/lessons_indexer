RSpec.describe LessonsIndexer::Options do
  it "should assign default options if no arguments are given" do
    options = described_class.new([])
    expect(options.path).to eq('.')
    expect(options.skip_index).to be_falsey
    expect(options.output).to eq('README.md')
    expect(options.git).to be_falsey
    expect(options.message).to eq('Added index')
    expect(options.all).to be_falsey
    expect(options.headings).to be_falsey
    expect(options.headings_dir).to eq('headers')
  end

  it "should allow to override some options" do
    argv = ['-p', 'test_path', '-g', '-o', 'test.md']
    options = described_class.new(argv)
    expect(options.path).to eq('test_path')
    expect(options.output).to eq('test.md')
    expect(options.git).to be_truthy
    expect(options.message).to eq('Added index')
    expect(options.all).to be_falsey
    expect(options.headings).to be_falsey
  end
end