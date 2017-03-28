class FixKyleBlunder < ActiveRecord::Migration
  def change
    remove_column :post_tags, :post_id_id
    remove_column :post_tags, :tag_id_id
  end
end
