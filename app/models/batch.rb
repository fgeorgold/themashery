class Batch
  include DataMapper::Resource
  
  property :id, Serial

  property :started_on, Date
  property :notes, Text

  belongs_to :user
  belongs_to :recipe

end
