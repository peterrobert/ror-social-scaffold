class SetDefaultFriendshipState < ActiveRecord::Migration[5.2]
  def change
    change_column :friendships, :status, :boolean, :default => false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
