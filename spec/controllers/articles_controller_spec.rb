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



# describe UploadDocumentsController, "handling DELETE /upload_documents/1" do
# 
#   before do
#     @upload_document = mock_model(UploadDocument, :destroy => true)
#     UploadDocument.stub!(:find).and_return(@upload_document)
#     UploadDocument.stub!(:authorized_for?).and_return(true)
#   end
# 
#   def do_delete
#     delete :destroy, :id => "1"
#   end
# 
#   it "should find the upload_document requested" do
#     UploadDocument.should_receive(:find).with("1").and_return(@upload_document)
#     do_delete
#   end
# 
#   it "should call destroy on the found upload_document" do
#     @upload_document.should_receive(:destroy)
#     do_delete
#   end
# 
#   it "should redirect to the upload_documents list" do
#     do_delete
#     response.should redirect_to(upload_documents_url)
#   end
# end
