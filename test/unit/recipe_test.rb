require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @recipe = Recipe.new(recipes(:lager).attributes)
    @recipe.id = nil
  end
  
  test "valid recipe should save" do
    assert @recipe.save, "Valid recipe fixture failed to save"
  end
  
  test "must have a title" do
    @recipe.title = nil
    assert !@recipe.save, "Recipe was saved without a title"
  end
  
  test "must have ingredients" do
    @recipe.ingredients = nil
    assert !@recipe.save, "Recipe was saved without ingredients"
  end
  
  test "must have directions" do
    @recipe.directions = nil
    assert !@recipe.save, "Recipe was saved without directions"
  end
end
