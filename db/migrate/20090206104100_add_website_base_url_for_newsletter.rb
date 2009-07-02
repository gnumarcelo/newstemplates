class AddWebsiteBaseUrlForNewsletter < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :url, :string
  end

  def self.down
    remove_column :newsletters, :url
  end
end
