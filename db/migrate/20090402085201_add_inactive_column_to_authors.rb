class AddInactiveColumnToAuthors < ActiveRecord::Migration
  def self.up
    add_column :authors, :inactive, :boolean
  end

  def self.down
    remove_column :authors, :inactive
  end
end
