require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe List do
  before(:each) do
    @valid_attributes = {
      :name => "my friends list",
      :cm_list_id => "00001abc"
    }
    @list = List.new(@valid_attributes)
  end

  it "should not be invalid when without name" do
    @list.should be_valid
    @list.name = nil
    @list.should_not be_valid
  end
  
  
end
