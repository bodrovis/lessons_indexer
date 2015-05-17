RSpec.describe LessonsIndexer::Addons::GitManager::Pusher do
  subject {described_class.new('test message')}

  specify "#message" do
    expect(subject.message).to eq('test message')
  end

  specify "#push!" do

      expect(-> { subject.push! }).to output("some output").to_stdout

  end
end