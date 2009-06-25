class Recipe < ActiveRecord::Base
  has_many :batches
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :user
  validates_associated :user
  
  validates_presence_of :title
  validates_presence_of :ingredients
  validates_presence_of :directions
end
