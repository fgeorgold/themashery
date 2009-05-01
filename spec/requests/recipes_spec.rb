require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a recipe exists" do
  request(resource(:recipes), :method => "POST", 
    :params => { :recipe => { :id => nil }})
end

describe "resource(:recipes)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:recipes))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of recipes" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a recipe exists" do
    before(:each) do
      @response = request(resource(:recipes))
    end
    
    it "has a list of recipes" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      @response = request(resource(:recipes), :method => "POST", 
        :params => { :recipe => { :id => nil }})
    end
    
    it "redirects to resource(:recipes)" do
    end
    
  end
end

describe "resource(@recipe)" do 
  describe "a successful DELETE", :given => "a recipe exists" do
     before(:each) do
       @response = request(resource(Recipe.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:recipes))
     end

   end
end

describe "resource(:recipes, :new)" do
  before(:each) do
    @response = request(resource(:recipes, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@recipe, :edit)", :given => "a recipe exists" do
  before(:each) do
    @response = request(resource(Recipe.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@recipe)", :given => "a recipe exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Recipe.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @recipe = Recipe.first
      @response = request(resource(@recipe), :method => "PUT", 
        :params => { :recipe => {:id => @recipe.id} })
    end
  
    it "redirect to the recipe show action" do
      @response.should redirect_to(resource(@recipe))
    end
  end
  
end

