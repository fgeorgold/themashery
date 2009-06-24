require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "must have recipe" do
    assert !batches(:no_recipe_id).save, "Batch saved without a recipe"
  end
  
  test "must have a brew date" do
    assert !batches(:no_brewed_on).save, "Batch saved without a brew date"
  end
  
  test "brew date must be today or earlier" do
    assert !batches(:brewed_tomorrow).save, "Batch saved with a brew date later than today"
  end
  
  test "valid batch fixture should save" do
    assert batches(:valid).save, "Valid batch fixture did not save"
  end
end
