class Recipe
  include DataMapper::Resource
  
  property :id, Serial

  property :title, String, :nullable => false
  property :notes, Text
  
  has n, :fermentable_assignments
  has n, :hop_assignments
  has n, :adjunct_assignments
  
  has n, :fermentables, :through => :fermentable_assignments
  has n, :hops, :through => :hop_assignments
  has n, :adjuncts, :through => :adjunct_assignments
  
  belongs_to :yeast
  
  belongs_to :user
  
  has n, :batches
  
  authorization do
    for_labels(:read, :create).use_policy(:user)
    for_labels(:update, :delete).use_policies(:owner, :admin)
  end
end
