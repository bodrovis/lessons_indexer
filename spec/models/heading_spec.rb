RSpec.describe LessonsIndexer::Models::Heading do
  let(:name) {'lesson1.2.jpg'}
  subject(:heading) {described_class.new(name)}

  specify "#file_name" do
    expect(heading.file_name).to eq(name)
  end

  specify "#path" do
    expect(heading.path).to eq(File.expand_path(name))
  end

  specify "#major" do
    expect(heading.major).to eq(1)
  end

  specify "#minor" do
    expect(heading.minor).to eq(2)
  end

  context "comparable" do
    let(:other_heading) {described_class.new('lesson2.5.jpg')}

    it "should be comparable" do
      expect(heading < other_heading).to be_truthy
    end
  end
end