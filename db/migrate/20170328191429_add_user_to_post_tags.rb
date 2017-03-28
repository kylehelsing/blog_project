class AddUserToPostTags < ActiveRecord::Migration
  def change
    add_reference :post_tags, :tag, index: true
    add_reference :post_tags, :post, index: true
  end
end
