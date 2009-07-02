class EditionsController < ApplicationController
  active_scaffold :edition do |config|
    config.columns['newsletter'].form_ui = :select
    config.list.columns = [:newsletter, :published_on, :state, :articles]
    config.list.sorting = [{:id => :desc}]
    config.actions.exclude :show
    config.create.columns.exclude :articles, :state
    config.update.columns.exclude :articles, :state
    
    config.columns['newsletter'].clear_link
    
    config.action_links.add 'Preview', :controller => 'preview', :action => 'index', :parameters => {:view => 'preview'}, :type => :record, :page => true, :popup => true
    config.action_links.add 'PDF', :controller => 'preview', :action => 'index', :parameters => {:view => 'preview', :format => 'pdf'}, :type => :record, :page => true, :popup => true
    config.action_links.add 'Upload/Send', :controller => 'preview', :action => 'index', :parameters => {:view => 'upload'}, :type => :record, :page => true
    config.action_links.add 'Export', :controller => 'preview', :action => 'index', :parameters => {:view => 'export'}, :type => :record, :page => true
    config.action_links.add 'Export Zip', :controller => 'preview', :action => 'download_files', :type => :record, :page => true
    config.action_links.add 'Reopen', :controller => 'preview', :action => 'reopen', :type => :record
    config.action_links.add 'Close', :controller => 'preview', :action => 'close', :type => :record
  end
end
