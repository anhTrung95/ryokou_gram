class AddAvatarFacebookToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_facebook, :string
  end
end
