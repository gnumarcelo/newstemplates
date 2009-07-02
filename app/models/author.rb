class Author < ActiveRecord::Base
  has_many :articles
  
  def name
    first_name + " " + last_name
  end
end
