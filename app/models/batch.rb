class Batch < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  
  validates_presence_of :recipe_id
  validates_presence_of :recipe
  validates_associated  :recipe
  
  validates_presence_of :user_id
  validates_presence_of :user
  validates_associated :user
  
  validates_inclusion_of :brewed_on, :in => (Date.new..Date.today), 
                         :message => "date must be today or earlier"
end
