class ListsController < ApplicationController
  active_scaffold :list do |config|
    config.columns[:newsletters].form_ui = :select
    config.columns << :cm_list_id
  end
end
