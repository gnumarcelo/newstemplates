require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WelcomeController do

  describe :index do
    it "should return the initial home page" do
      Article.stub!(:find).with(:all).and_return( [ mock_model(Article) , mock_model(Article) ])
      get :index
      assigns[:list].length.should equal(2)
    end
  end
  
end
