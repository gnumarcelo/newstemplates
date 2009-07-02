class ModifyNewslettersForCampaigning < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :send_automatically, :boolean
    add_column :newsletters, :confirmation_email, :string
  end

  def self.down
    remove_column :newsletters, :confirmation_email
    remove_column :newsletters, :send_automatically
  end
end
