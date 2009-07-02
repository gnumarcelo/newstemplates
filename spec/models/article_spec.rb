require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Article do
  # it { Article.should belong_to(:author) }
  # it { Article.should belong_to(:edition) }

  before do
    @valid_attributes = {
      :id => 777, 
      :title => "this is the article",
      :content => "This is the content",
      :author => Author.new(:first_name => "Simon", :last_name => "Garfield"),
      :edition_id => 999,
      :highlight => false
    }
    @article = Article.new
  end


  context "object validation" do
    it "should be valid with valid attributes" do
      @article.should_not be_valid
      @article.attributes = @valid_attributes
      @article.should be_valid
    end

    it "should be invalid without an author" do
      @article.attributes = @valid_attributes.except(:author)
      @article.should_not be_valid
      @article.author = Author.new(:first_name => "Simon", :last_name => "Garfield")
      @article.should be_valid
    end

    it "should be invalid with title shorter than 1 and longer than 100" do
      @article.attributes = @valid_attributes.except(:title)
      @article.should_not be_valid
      @article.title = "my article title"
      @article.should be_valid

      @article.title = "This is my article title with one hundred characters just to test if my model validation is working!"
      @article.should be_valid

      @article.title = "This is my article title with MORE THAN one hundred characters just to test if my model validation is working!"
      @article.should_not be_valid
    end
  end


  it "should convert article title to url format" do
    article = Article.new
    article.title = "This is my Apple article_15/12/2001"
    article.slug.should eql("this-is-my-apple-article_15-12-2001")
  end


  it "should create a link with the article title" do
    article = Article.new
    article.title = "My first article"
    article.slug_link.should be_include("My first article <a href=")
  end
  
  
  it "should get the first sentence from a given text" do
    article = Article.new
    article.content = "This is the content first sentence\n But the content has more then one sentence..."
    article.first_sentence.should eql("This is the content first sentence")
  end
  
  it "should convert euro symbol to html attribute" do
    article = Article.new
    article.content = "€ 150"
    article.clean_content.should  eql("&euro; 150")
  end
  
  it "should convert the content to html" do
    article = Article.new
    article.content = "*bold* _italic_ and my normal paragraph"
    article.to_html.should eql("<p><strong>bold</strong> <em>italic</em> and my normal paragraph</p>")
  end


end
