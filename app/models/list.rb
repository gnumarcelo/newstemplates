class List < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  
  has_and_belongs_to_many :newsletters
  
  # Populate lists from Campaign Monitor
  # This should validate that all current lists are present in Campaign Monitor
  # and it should create records for new lists.
  def self.populate
    cm_client.lists.each do |l|
      existing_list = List.find_by_name(l.name)
      if existing_list.nil?
        List.create!(:name => l.name, :cm_list_id => l.listID)
      else
        if existing_list.cm_list_id.nil?
          existing_list.cm_list_id = l.listID
          existing_list.save!
        else
          ids_match = (existing_list.cm_list_id == l.listID)
          raise "list IDs do not match" unless ids_match
        end
      end
    end
  end
  
  def self.cm_client
    Campaigning::Client.find_by_name(CAMPAIGN_MONITOR_CLIENT_NAME)
  end
  
  def list_from_name
    cm_client.find_list_by_name self.name
  end
end
