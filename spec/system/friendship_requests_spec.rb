require 'rails_helper'

RSpec.describe 'friendship request funcionality', type: :system do
  before :each do
    User.create(email: 'peter@info.com', name: 'peter', password: '111111', password_confirmation: '111111')
    User.create(email: 'ivan@info.com', name: 'ivan', password: '111111', password_confirmation: '111111')
  end

  it('should send a friend request') do
    visit('/users/sign_in')
    fill_in 'Email', with: 'peter@info.com'
    fill_in 'Password', with: '111111'
    click_button 'Log in'
    visit('/users')
    click_link 'Send friend request'
    expect(page).to have_content('Friendship request sent')
  end

  it('should accept the friendship request') do
    Friendship.create(inviter: User.first, invitee: User.last, status: false)
    visit('/users/sign_in')
    fill_in 'Email', with: 'ivan@info.com'
    fill_in 'Password', with: '111111'
    click_button 'Log in'
    visit('/friendships')
    click_link 'accept friendship'
    expect(page).to have_content('friendship accepted')
  end  

  it('should decline the invitation request') do
    Friendship.create(inviter: User.first, invitee: User.last, status: false)
    visit('/users/sign_in')
    fill_in 'Email', with: 'ivan@info.com'
    fill_in 'Password', with: '111111'
    click_button 'Log in'
    visit('/friendships')
    click_link 'decline friendship'
    expect(page).to have_content('the friendship request was declined')
  end
end
