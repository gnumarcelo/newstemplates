require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SearchController do
  
  it "should open the page to input the search query" do
    get :index
    response.should render_template('index')
  end
  
  it "should search for a query inputed" do
    @search = mock_model(Ultrasphinx::Search)
    @search.should_receive(:excerpt).with(no_args())
    @search.should_receive(:results).with(no_args())
    Ultrasphinx::Search.should_receive(:new).with(:query => "linux").and_return(@search)    
    post :results, :query => "linux"
    response.should render_template('results')
    
  end

end
