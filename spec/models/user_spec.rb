require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    peter = User.create(email: 'peter@info.com', name: 'peter', password: '111111', password_confirmation: '111111')
    ivan = User.create(email: 'ivan@info.com', name: 'ivan', password: '111111', password_confirmation: '111111')
    john = User.create(email: 'john@info.com', name: 'john', password: '111111', password_confirmation: '111111')
    Friendship.create(inviter: peter, invitee: ivan, status: true)
    Friendship.create(inviter: peter, invitee: john, status: false)
  end

  it 'should return pending friendship sent' do
    expect(User.first.friendships_sent.count).to eql(1)
  end

  it 'should return friendship requests recieved' do
    expect(User.find_by(name: 'john').pending_friendships.count).to eql(1)
  end

  it 'should return users who were sent friendship requests' do
    expect(User.first.request_user_list.count).to eql(1)
  end

  it 'should return users who have sent friendship requests to the user' do
    expect(User.find_by(name: 'john').pending_user_list.count).to eql(1)
  end

  it 'should return all friends' do
    expect(User.first.friends.count).to eql(2)
  end

  it 'should return pending friendships' do
    expect(User.find_by(name: 'john').pending_friendships.count).to eql(1)
  end
end
