class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.references :post_id, index: true
      t.references :tag_id, index: true

      t.timestamps null: false
    end
  end
end
