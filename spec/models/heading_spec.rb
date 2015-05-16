RSpec.describe LessonsIndexer::Models::Heading do
  subject(:heading) {described_class.new('lesson1.1.jpg')}

  specify "#file_name" do
    expect(heading.file_name).to eq('lesson1.1.jpg')
  end
end