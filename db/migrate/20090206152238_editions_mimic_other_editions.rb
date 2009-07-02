class EditionsMimicOtherEditions < ActiveRecord::Migration
  def self.up
    add_column :editions, :parent_edition_id, :integer
  end

  def self.down
    remove_column :editions, :parent_edition_id
  end
end
