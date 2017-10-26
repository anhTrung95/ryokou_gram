class AddPointToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :point, :integer, default: 0
  end
end
