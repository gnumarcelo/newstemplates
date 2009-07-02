class NewslettersController < ApplicationController
  active_scaffold :newsletter do |config|
    config.columns.exclude :editions, :articles, :created_at, :updated_at
    config.columns[:lists].form_ui = :select
    config.columns[:send_automatically].form_ui = :checkbox
    
    config.list.columns = [:title]
  end
end
