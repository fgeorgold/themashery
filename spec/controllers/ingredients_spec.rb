require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Ingredients, "index action" do
  before(:each) do
    dispatch_to(Ingredients, :index)
  end
end