require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Author do
  it { Author.should have_many(:articles) }

  before do
    @author = Author.new
  end
  
  it "should show the full the author name" do
    @author.first_name = "Robert"
    @author.last_name = "Plant"
    @author.name.should eql("Robert Plant")
  end
end
