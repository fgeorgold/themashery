class Fermentable
  include DataMapper::Resource
  
  property :id, Serial

  property :name, String, :nullable => false
  
  has n, :fermentable_assignments
  has n, :recipes, :through => :fermentable_assignments

end
