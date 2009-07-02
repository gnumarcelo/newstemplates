require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ArticlesController do

  before do
    #@article = mock_model(Article, :destroy => true)
    @article = mock_model(Article)
    Article.stub!(:find).and_return(@article)
    Article.stub!(:authorized_for?).and_return(true)
  end
  
  it "should have been using ActiveScaffold" do
    assert_not_nil ArticlesController.active_scaffold_config
    assert ArticlesController.active_scaffold_config.model == Article
  end
  
  it "should generate an article preview" do
    Article.should_receive(:find).with("1").and_return(@article)
    get :preview, :id => "1"
  end


  # FIXME: I didn't understand what is the 'source' method for.
  it "should generate a source of article" do
    Article.should_receive(:find).with("1").and_return(@article)
    get :source, :id => "1"
  end

end
