RSpec.describe LessonsIndexer::Indexer do
  subject { described_class.new(LessonsIndexer::Options.new(['-o', 'test.md'])) }

  before(:all) { setup_env! }

  after(:all) { clear_env! }

  specify "#options" do
    expect(subject.options.output).to eq('test.md')
  end
end