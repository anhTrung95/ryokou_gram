class CreatePlacePhotos < ActiveRecord::Migration
  def change
    create_table :place_photos do |t|
      t.integer :place_id
      t.string :photo

      t.timestamps null: false
    end
  end
end
