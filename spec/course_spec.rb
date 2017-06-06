RSpec.describe LessonsIndexer::Course do
  subject {described_class.new('my_course_handouts', 'headings')}

  specify "#dir" do
    expect(subject.dir).to eq('my_course_handouts')
  end

  specify "#title" do
    expect(subject.title).to eq('My Course')
  end

  specify "#headings_dir" do
    expect(subject.headings_dir).to eq('headings')
  end

  specify "#lessons" do
    expect(subject.lessons).to be_nil
  end

  specify "#headings" do
    expect(subject.headings).to be_nil
  end

  specify "#generate_index" do
    expect(subject).to receive(:lessons).and_return(sample_lessons)
    expect(subject.generate_index).to eq("# Index for the My Course course\n\n* [Lesson 1.3](my_course_handouts/lesson1.3.md)\n* [Lesson 2.5](my_course_handouts/lesson2.5.md)\n* [Lesson 5.8](my_course_handouts/lesson5.8.md)\n* [Lesson 10.2](my_course_handouts/lesson10.2.md)\n")
  end

  specify "#generate_pdfs" do
    expect(subject).to respond_to(:generate_pdfs)
  end

  specify "#generate_files" do
    expect(subject).to respond_to(:generate_files)
  end

  context "#generate_headings" do
    it "should return formatted heading and path to file" do
      expect(subject).to receive(:lessons).and_return(sample_lessons)
      expect(subject).to receive(:headings).and_return(sample_headings).exactly(4).times
      expect {|block| subject.generate_headings(&block)}.to yield_successive_args(
                                                              ["![](headings/lesson2.5.jpg)\n\n", "#{Dir.pwd}/lesson2.5.md"],
                                                              ["![](headings/lesson10.2.jpg)\n\n", "#{Dir.pwd}/lesson10.2.md"],
                                                              ["![](headings/lesson1.3.jpg)\n\n", "#{Dir.pwd}/lesson1.3.md"],
                                                              ["![](headings/lesson5.8.jpg)\n\n", "#{Dir.pwd}/lesson5.8.md"]
                                                            )
    end

    it "should warn if heading is not found" do
      expect(subject).to receive(:lessons).and_return(sample_lessons(true))
      expect(subject).to receive(:headings).and_return(sample_headings).exactly(5).times
      err = capture_stderr do
        expect {|block| subject.generate_headings(&block)}.to yield_successive_args(
                                                                ["![](headings/lesson2.5.jpg)\n\n", "#{Dir.pwd}/lesson2.5.md"],
                                                                ["![](headings/lesson10.2.jpg)\n\n", "#{Dir.pwd}/lesson10.2.md"],
                                                                ["![](headings/lesson1.3.jpg)\n\n", "#{Dir.pwd}/lesson1.3.md"],
                                                                ["![](headings/lesson5.8.jpg)\n\n", "#{Dir.pwd}/lesson5.8.md"]
                                                              )
      end.uncolorize
      expect(err).to eq("[WARNING] I was not able to find heading image for the Lesson 6.3\n")
    end
  end

  context "file system access" do
    before(:each) { setup_env! }

    after(:each) { clear_env! }

    context "#load_headings!" do
      let(:headings) {subject.load_headings!}

      specify { expect(headings).to be_a LessonsIndexer::Collections::HeadingsList }

      specify { expect(headings.map {|l| l.file_name}).not_to include('test2.png') }

      it "should have four items" do
        expect(headings.map {|l| l.file_name}.length).to eq(4)
      end

      specify "heading should be a kind of LessonsIndexer::Models::Heading" do
        expect(headings.first).to be_a LessonsIndexer::Models::Heading
      end
    end

    context "#load_lessons!" do
      let(:lessons) {subject.load_lessons!}

      specify { expect(lessons).to be_a LessonsIndexer::Collections::LessonsList }

      specify { expect(lessons.map {|l| l.name}).not_to include('Test') }

      it "should have four items" do
        expect(lessons.map {|l| l.name}.length).to eq(4)
      end

      specify "lesson should be a kind of LessonsIndexer::Models::Lesson" do
        expect(lessons.first).to be_a LessonsIndexer::Models::Lesson
      end
    end
  end
end