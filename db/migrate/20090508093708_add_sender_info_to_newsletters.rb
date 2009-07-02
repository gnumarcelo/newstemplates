class AddSenderInfoToNewsletters < ActiveRecord::Migration
  def self.up
    add_column :newsletters, :from_email, :string
    add_column :newsletters, :reply_to_email, :string
    add_column :newsletters, :from_name, :string
    add_column :newsletters, :short_name, :string
    add_column :newsletters, :email_subject, :string
  end

  def self.down
    remove_column :newsletters, :email_subject
    remove_column :newsletters, :short_name
    remove_column :newsletters, :from_name
    remove_column :newsletters, :reply_to_email
    remove_column :newsletters, :from_email
  end
end
