RSpec.describe LessonsIndexer::Collections::LessonsList do
  subject { sample_lessons }

  context "#list" do
    it "should respond to #each" do
      expect(subject).to respond_to(:each)
    end

    it "should be sorted properly" do
      sorted_lessons = subject.sort
      %w(1.3 2.5 5.8 10.2).each_with_index do |version, index|
        expect(sorted_lessons[index].file_name).to eq "lesson#{version}.md"
      end
    end
  end
end