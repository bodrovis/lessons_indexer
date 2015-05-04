require 'spec_helper'

module LessonsIndexer
  RSpec.describe Writer do
    let(:writer) { Writer.new('test.txt') }
    before :each do
      writer << 'test'
    end

    it "should write" do
      contents = IO.read(writer.file)
      expect(contents).to eq('test')
    end

    it "should close the file after writing" do
      expect(writer.file).to be_closed
    end
  end
end