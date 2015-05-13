module LessonsIndexer
  RSpec.describe Writer do
    before :each do
      @writer = Writer.new('test.txt')
      @writer << 'test'
    end
    after(:all) {File.delete('test.txt')}

    specify "#name" do
      expect(@writer.name).to eq('test.txt')
    end

    specify "#<<" do
      contents = IO.read(@writer.name)
      expect(contents).to eq('test')
    end

    context "#prepend_data" do
      before(:each) {@writer.prepend_data('prepended')}
      it "should add data to the beginning" do
        expect(IO.read(@writer.name)).to eq('prependedtest')
      end

      it "should not add data to the beginning if data is already present" do
        @writer.prepend_data('prepended')
        expect(IO.read(@writer.name)).to eq('prependedtest')
      end
    end
  end
end