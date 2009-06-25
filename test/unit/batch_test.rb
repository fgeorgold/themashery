require 'test_helper'

class BatchTest < ActiveSupport::TestCase
  def setup
    @batch = Batch.new(batches(:one).attributes)
    @batch.id = nil
  end
  
  test "valid batch fixture should save" do
    assert @batch.save, "Valid batch fixture did not save"
  end
  
  test "must have recipe" do
    @batch.recipe_id = nil
    assert !@batch.save, "Batch saved without a recipe"
  end
  
  test "must have a brew date" do
    @batch.brewed_on = nil
    assert !@batch.save, "Batch saved without a brew date"
  end
  
  test "brew date must be today or earlier" do
    @batch.brewed_on = (Date.today + 1).to_s
    assert !@batch.save, "Batch saved with a brew date later than today"
  end
  
  test "associated recipe must exist and be valid" do
    @batch.recipe_id = 0
    assert !@batch.save, "Batch saved with an invalid recipe"
  end
end
