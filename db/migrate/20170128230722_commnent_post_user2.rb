class CommnentPostUser2 < ActiveRecord::Migration[5.0]
  def change
    remove_column :post_comments, :user_id
    add_reference :post_comments, :user, index: true
  end
end
