RSpec.describe LessonsIndexer::Models::Lesson do
  let(:name) {'lesson1.2.md'}
  subject(:lesson) {described_class.new(name)}

  specify "#file_name" do
    expect(lesson.file_name).to eq(name)
  end

  specify "#path" do
    expect(lesson.path).to eq(File.expand_path(name))
  end

  specify "#major" do
    expect(lesson.major).to eq(1)
  end

  specify "#minor" do
    expect(lesson.minor).to eq(2)
  end

  specify "#name" do
    expect(lesson.name).to eq('Lesson 1.2')
  end

  specify "#link" do
    expect(lesson.link('dir')).to eq("* [Lesson 1.2](dir/#{name})\n")
  end

  context "comparable" do
    let(:other_lesson) {described_class.new('lesson1.1.md')}

    it "should be comparable" do
      expect(lesson > other_lesson).to be_truthy
    end
  end
end