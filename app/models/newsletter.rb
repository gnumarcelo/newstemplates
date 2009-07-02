class Newsletter < ActiveRecord::Base
  has_many :editions
  has_and_belongs_to_many :lists

end
