class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
  end
end
