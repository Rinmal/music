class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.timestamps
      t.integer :following_id, null: false, foreign_key: true
      t.integer :follower_id, null: false, foreign_key: true
    end
  end
end
