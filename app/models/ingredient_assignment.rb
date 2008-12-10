class IngredientAssignment
  include DataMapper::Resource
  
  property :id, Serial
  property :type, Discriminator
  
  property :quantity, Float, :nullable => false
  property :units, String, :nullable => false
  
#  validates_with_block :quantity do
#    if quantity && quantity > 0.0
#      true
#    else
#      [false, "Quantity must be greater than 0"]
#    end
#  end
  
#  validates_with_block :type do
#    if descendants.include?(Object.full_const_get(type || ""))
#      true
#    else
#      [false, "Invalid type specified"]
#    end
#  end

  belongs_to :recipe
end

class FermentableAssignment < IngredientAssignment
  belongs_to :fermentable
end

class HopAssignment < IngredientAssignment
  belongs_to :hop
end

class AdjunctAssignment < IngredientAssignment
  belongs_to :adjunct
end
