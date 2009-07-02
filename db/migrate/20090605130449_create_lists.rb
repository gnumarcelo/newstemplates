class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :name, :cm_list_id
    end
    
    create_table(:lists_newsletters, :id => false) do |t|
      t.integer :list_id, :newsletter_id
    end
  end

  def self.down
    drop_table :lists
    drop_table :lists_newsletters
  end
end
