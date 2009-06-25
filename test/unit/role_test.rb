require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test "role must have a name" do
    assert !Role.new.save, "Role saved without a name"
  end
end
