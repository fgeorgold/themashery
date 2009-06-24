require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "must have a title" do
    assert !recipes(:no_title).save, "Recipe was saved without a title"
  end
  
  test "must have ingredients" do
    assert !recipes(:no_ingredients).save, "Recipe was saved without ingredients"
  end
  
  test "must have directions" do
    assert !recipes(:no_directions).save, "Recipe was saved without directions"
  end
  
  test "valid recipe should save" do
    assert recipes(:valid).save, "Valid recipe fixture failed to save"
  end
end
