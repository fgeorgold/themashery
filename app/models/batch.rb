class Batch < ActiveRecord::Base
  validates_presence_of :recipe_id
  validates_inclusion_of :brewed_on, :in => (Date.new..Date.today), :message => "date must be today or earlier"
end
