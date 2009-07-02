class AuthorsController < ApplicationController
  active_scaffold :authors do |config|
    config.columns = [:first_name, :last_name, :inactive]
    config.columns[:inactive].form_ui = :checkbox
  end
end
