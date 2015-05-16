RSpec.describe LessonsIndexer::Collections::LessonsList do
  subject(:lessons) do
    described_class.new(%w(lesson2.5.md lesson10.2.md lesson1.3.md lesson5.8.md).map do |name|
                          LessonsIndexer::Models::Lesson.new(name)
                        end)
  end

  context "#list" do
    it "should respond to #each" do
      expect(lessons).to respond_to(:each)
    end

    it "should be sorted properly" do
      sorted_lessons = lessons.sort
      %w(1.3 2.5 5.8 10.2).each_with_index do |version, index|
        expect(sorted_lessons[index].file_name).to eq "lesson#{version}.md"
      end
    end
  end
end