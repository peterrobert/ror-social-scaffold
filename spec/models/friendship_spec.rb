require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    peter = User.create(email: 'peter@info.com', name: 'peter', password: '111111', password_confirmation: '111111')
    john = User.create(email: 'john@info.com', name: 'john', password: '111111', password_confirmation: '111111')
    Friendship.create(inviter: peter, invitee: john, status: false)
  end

  it 'should set the status of the friendship request to accepted' do
    Friendship.first.accept_friendship
    expect(Friendship.first.status).to eql(true)
  end
end
