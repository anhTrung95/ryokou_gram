class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rate
      t.references :user, index: true, foreign_key: true
      t.references :place, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :reviews, [:user_id, :place_id, :created_at]
  end
end
