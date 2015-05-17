RSpec.describe LessonsIndexer::Addons::GitManager::Pusher do
  subject {described_class.new('test message')}

  specify "#message" do
    expect(subject.message).to eq('test message')
  end

  specify { expect(subject).to respond_to(:push!) }
end

RSpec.describe LessonsIndexer::Addons::GitManager::Brancher do
  subject {described_class.new(false)}

  specify "#ignore_master" do
    expect(subject.ignore_master).to eq(false)
  end

  specify { expect(subject).to respond_to(:within_branch) }

  specify "#get_branches" do
    expect(subject.get_branches).to be_a Array
  end
end