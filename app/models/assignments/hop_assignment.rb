class HopAssignment
  include DataMapper::Resource
  
  property :id, Serial

  property :units, String, :nullable => false
  property :quantity, Float, :nullable => false
  
  validates_with_block :quantity do
    if quantity && quantity > 0.0
      true
    else
      [false, "Quantity must be greater than 0"]
    end
  end
  
  belongs_to :hop
  belongs_to :recipe

end
