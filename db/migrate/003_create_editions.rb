class CreateEditions < ActiveRecord::Migration
  def self.up
    create_table :editions do |t|
      t.date :published_on
      t.integer :newsletter_id
      t.string :state
      t.timestamps
    end
  end

  def self.down
    drop_table :editions
  end
end
