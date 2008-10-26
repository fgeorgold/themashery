require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a ingredient exists" do
  Ingredient.all.destroy!
  request(resource(:ingredients), :method => "POST", 
    :params => { :ingredient => { :id => nil }})
end

describe "resource(:ingredients)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:ingredients))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of ingredients" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a ingredient exists" do
    before(:each) do
      @response = request(resource(:ingredients))
    end
    
    it "has a list of ingredients" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Ingredient.all.destroy!
      @response = request(resource(:ingredients), :method => "POST", 
        :params => { :ingredient => { :id => nil }})
    end
    
    it "redirects to resource(:ingredients)" do
      @response.should redirect_to(resource(Ingredient.first), :message => {:notice => "ingredient was successfully created"})
    end
    
  end
end

describe "resource(@ingredient)" do 
  describe "a successful DELETE", :given => "a ingredient exists" do
     before(:each) do
       @response = request(resource(Ingredient.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:ingredients))
     end

   end
end

describe "resource(:ingredients, :new)" do
  before(:each) do
    @response = request(resource(:ingredients, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@ingredient, :edit)", :given => "a ingredient exists" do
  before(:each) do
    @response = request(resource(Ingredient.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@ingredient)", :given => "a ingredient exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Ingredient.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @ingredient = Ingredient.first
      @response = request(resource(@ingredient), :method => "PUT", 
        :params => { :article => {:id => @ingredient.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@ingredient))
    end
  end
  
end

