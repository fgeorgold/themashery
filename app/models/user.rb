class User < ActiveRecord::Base
  acts_as_authentic
  
  has_many :batches
  has_many :recipes
end
