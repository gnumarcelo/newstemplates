class ArticlesController < ApplicationController
  active_scaffold :article do |config|
    config.columns.exclude :created_at, :updated_at
    config.actions.exclude :show
    
    config.list.sorting = [{:edition_id, :asc}, {:position => :asc}]
    config.list.columns   = [:edition, :author, :title, :content]
    config.create.columns = [:edition, :author, :title, :content, :highlight]
    config.update.columns = [:edition, :author, :title, :content, :highlight]
    
    config.create.link.inline = false # Edit articles in their own separate page.
    
    config.columns['edition'].form_ui = :select
    config.columns['author'].form_ui = :select
    config.columns['highlight'].form_ui = :checkbox
    
    config.columns['edition'].clear_link
    config.columns['author'].clear_link
    
    config.action_links.add "Preview", :action => 'preview', :type => :record
  end
  
  def preview
    @article = Article.find(params[:id])
  end
  
  def source
    @article = Article.find(params[:id])
  end
  
  def conditions_for_collection
    "edition_id IS NULL or editions.state ='open'"
  end
end
