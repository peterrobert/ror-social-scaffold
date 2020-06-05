class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, class_name: 'Friendship', foreign_key: 'inviter_id'

  has_many :friends, through: :friendships, source: 'invitee'

  def pending_friendships
    Friendship.where(invitee: self).select { |i| i.status == false }
  end

  def friendships_sent
    Friendship.where(inviter: self).select { |i| i.status == false }
  end

  def request_user_list
    users_list = []
    friendships_sent.each do |i|
      users_list << User.where(id: i.invitee.id)
    end
    users_list
  end

  def pending_user_list
    users_list = []
    pending_friendships.each do |i|
      users_list << User.where(id: i.inviter.id)
    end
    users_list
  end
end
