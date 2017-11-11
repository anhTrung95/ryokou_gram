class AddImagesToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :images, :string
  end
end
