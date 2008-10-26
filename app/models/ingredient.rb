class Ingredient
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, :nullable => false
  property :quantity, Float, :nullable => false
  property :units, String, :nullable => false
  property :type, Discriminator

end

class Fermentable < Ingredient; end
class Hop < Ingredient; end
class Adjunct < Ingredient; end
class Yeast < Ingredient; end

class Grain < Fermentable; end
class Extract < Fermentable; end
