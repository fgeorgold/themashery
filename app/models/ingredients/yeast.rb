class Yeast
  include DataMapper::Resource
  
  property :id, Serial

  property :name, String, :nullable => false
  
  has n, :recipes

end
