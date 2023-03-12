class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|

      t.timestamps
      t.integer :user_id, null: false, foreign_key: true
      t.integer :group_id, null: false, foreign_key: true
      t.text :message, null: false
    end
  end
end
