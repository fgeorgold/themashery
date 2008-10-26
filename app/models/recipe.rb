class Recipe
  include DataMapper::Resource
  
  property :id, Serial

  property :title, String
  property :notes, Text
  
  belongs_to :user
  
  has n, :batches

end
