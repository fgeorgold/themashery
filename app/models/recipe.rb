class Recipe < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :ingredients
  validates_presence_of :directions
end
