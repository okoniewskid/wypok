class ChangeNameColumnDescriptionInTheLinks < ActiveRecord::Migration[5.0]
  def self.up
    rename_column :links, :opis, :description
    change_column_default :links, :description, ""
  end

  def self.down

  end
end
