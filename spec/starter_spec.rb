RSpec.describe LessonsIndexer::Starter do
  subject { described_class.new([]) }

  specify { expect(subject.options).to be_a LessonsIndexer::Options }

  context "#start!" do
    it {is_expected.to respond_to(:start!)}
  end
end