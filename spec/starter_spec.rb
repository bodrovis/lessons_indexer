RSpec.describe LessonsIndexer::Starter do
  subject { described_class.new([]) }

  specify "#options" do
    expect(subject.options).to be_a LessonsIndexer::Options
  end

  specify "#start" do
    expect(subject).to respond_to(:start!)
  end
end