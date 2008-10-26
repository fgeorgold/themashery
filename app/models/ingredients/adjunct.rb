class Adjunct
  include DataMapper::Resource
  
  property :id, Serial

  property :name, String, :nullable => false
  
  has n, :adjunct_assignments
  has n, :recipes, :through => :adjunct_assignments

end
