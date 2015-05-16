RSpec.describe LessonsIndexer::Collections::HeadingsList do
  subject(:headings) do
    described_class.new(%w(lesson2.3.jpg lesson1.2.jpg lesson11.3.jpg lesson5.8.jpg).map do |name|
                          LessonsIndexer::Models::Heading.new(name)
                        end)
  end

  context "#for" do
    it "should return heading for a lesson" do
      lesson = double('lesson', major: 2, minor: 3)
      expect(headings.for(lesson)).to eq(headings.first)
    end

    it "should return nil if heading does not exist" do
      lesson = double('lesson', major: 10, minor: 5)
      expect(headings.for(lesson)).to be_nil
    end
  end

  context "#list" do
    it "should respond to #each" do
      expect(headings).to respond_to(:each)
    end

    it "should be sorted properly" do
      sorted_headings = headings.sort
      %w(1.2 2.3 5.8 11.3).each_with_index do |version, index|
        expect(sorted_headings[index].file_name).to eq "lesson#{version}.jpg"
      end
    end
  end
end