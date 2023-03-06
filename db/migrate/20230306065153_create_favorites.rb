class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.timestamps
      t.integer :user_id, null: false, foreign_key: true
      t.integer :post_id, null: false, foreign_key: true
    end
  end
end
