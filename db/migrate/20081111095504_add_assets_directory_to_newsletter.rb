class AddAssetsDirectoryToNewsletter < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :assets, :string
  end

  def self.down
    remove_column :newsletters, :assets
  end
end
