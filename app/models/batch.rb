class Batch
  include DataMapper::Resource
  
  property :id, Serial
  property :created_on, Date

  belongs_to :user
  belongs_to :recipe

end
