class CommnetPostUser < ActiveRecord::Migration[5.0]
  def change
    add_column :post_comments, :user_id, :integer
    add_index :post_comments, :user_id
    remove_column :post_comments, :name
  end
end
