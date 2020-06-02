class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :outgoing_friendships, class_name: "Friendship", foreign_key: "inviter_id"
  has_many :incoming_friendships, class_name: "Friendship", foreign_key: "invitee_id"

  has_many :incoming_friends, through: :incoming_friendships, source: 'inviter'
  has_many :outgoing_friends, through: :outgoing_friendships, source: 'invitee'

  def friends
    incoming_friends + outgoing_friends
  end

  def pending_friendships
     incoming_friendships.select { |i| i.status == false }
  end
end
