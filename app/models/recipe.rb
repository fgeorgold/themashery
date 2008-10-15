class Recipe
  include DataMapper::Resource
  
  property :id, Serial
  
  property :title, String, :nullable => false
  property :ingredients, Text, :default => ""
  property :notes, Text, :default => ""
  
  belongs_to :user
  
  has n, :batches

end
