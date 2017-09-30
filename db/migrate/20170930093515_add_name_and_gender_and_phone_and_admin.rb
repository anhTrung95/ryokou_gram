class AddNameAndGenderAndPhoneAndAdmin < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :boolean
    add_column :users, :phone, :string
    add_column :users, :admin, :boolean
  end
end
