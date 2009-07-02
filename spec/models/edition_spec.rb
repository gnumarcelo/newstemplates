require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Edition do
  it { Edition.should belong_to(:newsletter) }
  it { Edition.should have_many(:articles) }

  before(:each) do
    @newsletter_valid_attributes = {
      :from_email => "user@example.com",
      :reply_to_email => "no-reply@example.com",
      :confirmation_email => "user@example.com",
      :from_name => "Mr. John Dog",
      :short_name => "New Car sales",
      :email_subject => "By a new car today",
      :title => "Need a new car",
      :template => "none",
      :url =>  "http://my-campaign.example.com"
    }
    @valid_attributes = {
      :id => 123,
      :newsletter => Newsletter.new(@newsletter_valid_attributes),
      :parent_edition_id => 789,
      :state => :open,
      :published_on => Date.new(y=2008,m=07,d=16)
    }
    @edition = Edition.new(@valid_attributes)
  end

  it "should not be valid without a newsletter" do
    @edition.newsletter = nil
    @edition.should_not be_valid
    @edition.newsletter = Newsletter.new(@newsletter_valid_attributes)
    @edition.should be_valid
  end  

  it "should return a label for itself" do
    @edition.to_label.should eql("Need a new car 2008-07-16 Wed")
    @edition.newsletter.title = nil
    @edition.to_label.should eql("Untitled")
    @edition.newsletter.title = "Need a new car"
    @edition.published_on = nil
    @edition.to_label.should eql("Untitled")
  end

  it "should generate a pdf file name" do
    @edition.pdf_filename.should eql("need-a-new-car-2008-07-16.pdf")
  end

  it "should generate a link to a pdf version" do
    @edition.pdf_version("new_car_campaign").should eql("<a href=\"http://my-campaign.example.com/pdf/2008/need-a-new-car-2008-07-16.pdf\">new_car_campaign</a>")
    @edition.pdf_version.should eql("<a href=\"http://my-campaign.example.com/pdf/2008/need-a-new-car-2008-07-16.pdf\">http://my-campaign.example.com/pdf/2008/need-a-new-car-2008-07-16.pdf</a>") 
  end

  it "should generate a html url" do
    @edition.html_url.should eql("http://my-campaign.example.com/2008/07/16/")
  end

  it "should generate a link to web version" do
    @edition.web_version.should eql("<a href=\"http://my-campaign.example.com/2008/07/16/\">View it in your browser</a>")
    @edition.web_version("view a edition in web").should eql("<a href=\"http://my-campaign.example.com/2008/07/16/\">view a edition in web</a>")
  end

  it "should generate a campaign name" do
    @edition.campaign_name.should eql("New Car sales 2008-07-16")
  end

end

describe Edition, "campaign monitor API" do
  before(:each) do
    @edition = Edition.new
  end

  # it "should retrieve Bloxham client id" do
  #   @edition.cm_client.clientID.should === "b43c64d45a769cd3a743399d35c3cf7a"
  # end
end