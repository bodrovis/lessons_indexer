RSpec.describe LessonsIndexer::Indexer do
  before(:all) { setup_env! }
  after(:all) { clear_env! }

  subject { described_class.new(LessonsIndexer::Options.new(sample_options)) }
  let(:course) {LessonsIndexer::Course.new(subject.get_course_dir, subject.options.headings_dir)}

  context "#options" do
    it "should return output" do
      expect(subject.options.output).to eq('test.md')
    end
  end

  context "#do_work!" do
    it "should build index if --skip_index is not set" do
      expect(subject).to receive(:build_index)
      expect(subject).not_to receive(:add_headings)
      expect(subject).not_to receive(:git_push!)
      capture_stdout { subject.do_work! }
    end

    it "should add headings if --headings is set" do
      allow(subject.options).to receive(:skip_index).and_return(true)
      allow(subject.options).to receive(:headings).and_return(true)
      expect(subject).to receive(:add_headings)
      expect(subject).not_to receive(:build_index)
      expect(subject).not_to receive(:git_push!)
      capture_stdout { subject.do_work! }
    end

    it "should push to github if --git is set" do
      allow(subject.options).to receive(:skip_index).and_return(true)
      allow(subject.options).to receive(:git).and_return(true)
      expect(subject).to receive(:git_push!)
      expect(subject).not_to receive(:build_index)
      expect(subject).not_to receive(:add_headings)
      capture_stdout { subject.do_work! }
    end

    it "should generate pdfs if --pdf is set" do
      allow(subject.options).to receive(:skip_index).and_return(true)
      allow(subject.options).to receive(:pdf).and_return(true)
      expect(subject).to receive(:generate_pdfs)
      capture_stdout { subject.do_work! }
    end
  end

  context "#get_course_dir" do
    it "should return course dir" do
      expect(subject.get_course_dir).to eq('my_course_handouts')
    end

    it "should abort if course dir is not found" do
      Kernel.within 'my_course_handouts', true do
        err = capture_stderr do
          expect(-> {subject.get_course_dir}).to raise_error(SystemExit)
        end.uncolorize
        expect(err).to eq("[ERROR] Lesson files were not found inside the provided directory. Aborting...\n")
      end
    end
  end

  context "#build_index" do
    it "should display proper info messages" do
      info = capture_stdout do
        subject.build_index(course)
      end.uncolorize
      expect(info).to eq("Starting to build index...\nIndex for the My Course course is generated!\n#{'=' * 50}\n")
    end

    it "should generate proper index" do
      capture_stdout { subject.build_index(course) }
      expect(IO.read('test.md')).to eq("# Index for the My Course course\n\n* [Lesson 1.3](my_course_handouts/lesson1.3.md)\n* [Lesson 2.5](my_course_handouts/lesson2.5.md)\n* [Lesson 5.8](my_course_handouts/lesson5.8.md)\n* [Lesson 10.2](my_course_handouts/lesson10.2.md)\n")
    end
  end

  context "#add_headings" do
    it "should display proper info messages" do
      info = capture_stdout do
        subject.add_headings(course)
      end.uncolorize
      expect(info).to eq("Starting to add headings...\nHeadings for the lesson files of My Course course were added!\n#{'=' * 50}\n")
    end

    it "should generate proper index" do
      capture_stdout { subject.add_headings(course) }
      expect(IO.read('my_course_handouts/lesson10.2.md')).to eq("![](headings/lesson10.2.jpg)\n\n")
    end
  end
end