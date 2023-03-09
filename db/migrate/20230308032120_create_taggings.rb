class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|

      t.timestamps
      t.integer :post_id, null: false, foreign_key: true
      t.integer :tag_id, null: false, foreign_key: true
    end
  end
end
