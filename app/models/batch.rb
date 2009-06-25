class Batch < ActiveRecord::Base
  belongs_to :recipe
  
  validates_presence_of :recipe_id
  validates_presence_of :recipe
  validates_associated  :recipe
  
  validates_inclusion_of :brewed_on, :in => (Date.new..Date.today), 
                         :message => "date must be today or earlier"
end
