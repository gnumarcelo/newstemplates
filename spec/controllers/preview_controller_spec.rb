require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PreviewController do

  before do
    #@edition = mock_model(Edition, :destroy => true)
    @edition = mock_model(Edition)
    Edition.stub!(:find).and_return(@article)
    Edition.stub!(:authorized_for?).and_return(true)
  end
  
  
  it "should reopen an Edition" do
    Edition.should_receive(:find).with("1").and_return(@edition)
    @edition.should_receive(:reopen!).with(no_args())
    get :reopen, :id => "1"
  end


  it "should close an Edition" do
    Edition.should_receive(:find).with("1").and_return(@edition)
    @edition.should_receive(:close!).with(no_args())
    get :reopen, :id => "1"
  end

  
end
