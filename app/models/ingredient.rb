class Ingredient
  include DataMapper::Resource
  
  property :id, Serial
  property :type, Discriminator
  
  property :name, String, :nullable => false
  
  belongs_to :user
  
  authorization do
    for_labels(:read, :create).use_policy(:user)
    for_labels(:update, :delete).use_policies(:owner, :admin)
  end
  
#  validates_with_block :type do
#    if descendants.include?(Object.full_const_get(type || ""))
#      true
#    else
#      [false, "Invalid type specified"]
#    end
#  end

end

class Fermentable < Ingredient; end
class Hop < Ingredient; end
class Adjunct < Ingredient; end
class Yeast < Ingredient; end

