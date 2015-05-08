module LessonsIndexer
  RSpec.describe Writer do
    let(:writer) { Writer.new('test.txt') }
    before :each do
      writer << 'test'
    end

    it "should write" do
      contents = IO.read(writer.name)
      expect(contents).to eq('test')
    end
  end
end