require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  test "valid batch fixture should save" do
    assert batches(:valid).save, "Valid batch fixture did not save"
  end
  
  test "must have recipe" do
    assert !batches(:no_recipe).save, "Batch saved without a recipe"
  end
  
  test "must have a brew date" do
    assert !batches(:no_brewed_on).save, "Batch saved without a brew date"
  end
  
  test "brew date must be today or earlier" do
    assert !batches(:brewed_tomorrow).save, "Batch saved with a brew date later than today"
  end
  
  test "associated recipe must exist" do
    puts batches(:invalid_recipe).attributes.inspect
    assert !batches(:invalid_recipe).save, "Batch saved with an invalid recipe"
    
    recipe = recipes(:valid)
    recipe.save
    
    batch = batches(:invalid_recipe)
    batch.recipe = recipe
    assert batch.save, "Batch with a valid recipe did not save"
  end
end
