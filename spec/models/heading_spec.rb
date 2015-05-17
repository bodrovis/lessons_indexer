RSpec.describe LessonsIndexer::Models::Heading do
  let(:name) {'lesson1.2.jpg'}
  subject {described_class.new(name)}

  specify "#file_name" do
    expect(subject.file_name).to eq(name)
  end

  specify "#path" do
    expect(subject.path).to eq(File.expand_path(name))
  end

  specify "#major" do
    expect(subject.major).to eq(1)
  end

  specify "#minor" do
    expect(subject.minor).to eq(2)
  end

  context "comparable" do
    let(:other_heading) {described_class.new('lesson2.5.jpg')}

    it "should be comparable" do
      expect(subject < other_heading).to be_truthy
    end
  end
end