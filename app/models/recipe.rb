class Recipe
  include DataMapper::Resource
  
  property :id, Serial
  
  property :title, String, :nullable => false
  property :ingredients, Text
  property :notes, Text
  
  belongs_to :user
  
  has n, :batches

end
