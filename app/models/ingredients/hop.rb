class Hop
  include DataMapper::Resource
  
  property :id, Serial

  property :name, String, :nullable => false
  
  has n, :hop_assignments
  has n, :recipes, :through => :hop_assignments

end
