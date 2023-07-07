require 'rails_helper'

RSpec.describe Entity, type: :model do
  before(:each) do
    @user = User.create!(name: 'raihan', email: 'a@gmail.com', password: '123456', confirmed_at: Time.now)
    @entity = Entity.create!(name: 'apple', amount: 230, author: @user)
  end

  it 'should have a correct name' do
    expect(@entity.name).to eq('apple')
    @entity.name = nil
    expect(@entity).to_not be_valid
  end

  it 'should have a correct email' do
    expect(@entity.amount).to eq(230)
    @entity.amount = nil
    expect(@entity).to_not be_valid
  end

  it 'should have a correct user' do
    expect(@entity.author).to eq(@user)
    @entity.author = nil
    expect(@entity).to_not be_valid
  end
end
