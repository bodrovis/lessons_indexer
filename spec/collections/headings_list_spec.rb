RSpec.describe LessonsIndexer::Collections::HeadingsList do
  subject { sample_headings }

  context "#for" do
    it "should return heading for a lesson" do
      lesson = double('lesson', major: 2, minor: 5)
      expect(subject.for(lesson)).to eq(subject.first)
    end

    it "should return nil if heading does not exist" do
      lesson = double('lesson', major: 10, minor: 5)
      expect(subject.for(lesson)).to be_nil
    end
  end

  context "#list" do
    it "should respond to #each" do
      expect(subject).to respond_to(:each)
    end

    it "should be sorted properly" do
      sorted_headings = subject.sort
      %w(1.3 2.5 5.8 10.2).each_with_index do |version, index|
        expect(sorted_headings[index].file_name).to eq "lesson#{version}.jpg"
      end
    end
  end
end