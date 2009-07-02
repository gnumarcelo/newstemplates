class AddBoldSwitchToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :highlight, :boolean
  end

  def self.down
    remove_column :articles, :highlight
  end
end
