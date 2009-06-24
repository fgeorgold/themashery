class Recipe < ActiveRecord::Base
  has_many :batches
  
  validates_presence_of :title
  validates_presence_of :ingredients
  validates_presence_of :directions
end
