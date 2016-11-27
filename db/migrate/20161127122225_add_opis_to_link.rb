class AddOpisToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :opis, :text
  end
end
