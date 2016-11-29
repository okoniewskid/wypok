class ChangeNameColumnDescriptionInTheLinks < ActiveRecord::Migration[5.0]
  def change
    rename_column :links, :opis, :description
    change_column_default :links, :description, ''
  end
end
