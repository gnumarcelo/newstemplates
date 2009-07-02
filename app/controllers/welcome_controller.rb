class WelcomeController < ApplicationController
  def index
    @list = Article.find(:all)
  end
end
