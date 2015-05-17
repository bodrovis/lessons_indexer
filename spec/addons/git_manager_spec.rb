RSpec.describe LessonsIndexer::Addons::GitManager::Pusher do
  subject {described_class.new('test message')}

  specify "#message" do
    expect(subject.message).to eq('test message')
  end

  specify "#push!" do
    input = capture_stdin do
      subject.push!
    end
    expect(input).to eq('test')
  end
end