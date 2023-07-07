require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:icon) do
    Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', '85968941.jpg'), 'image/jpeg')
  end

  subject { Group.new(name: 'Food', icon:) }
  before { subject.save }

  it 'should have a correct name' do
    expect(subject.name).to eq('Food')
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a correct icon' do
    expect(subject.icon).to be_attached
    subject.icon = nil
    expect(subject).to_not be_valid
  end
end
