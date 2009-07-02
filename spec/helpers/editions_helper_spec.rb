require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EditionsHelper do

  before do
    @edition = mock_model(Edition)
    @article1 = mock_model(Article, :title => "First impression")
    @article2 = mock_model(Article, :title => "Second Impression")
    @edition.stub!(:articles).and_return([@article1, @article2])
  end
  
  it "should separate article titles with comma" do
    result = helper.articles_column(@edition)
    result.should be_eql "First impression, Second Impression"
  end
  
end
