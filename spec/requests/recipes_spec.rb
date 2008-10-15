require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a recipe exists" do
  request(resource(:recipes), :method => "POST", 
    :params => { :recipe => {  }})
end

describe "resource(:recipes)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:recipes))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of speakers" do
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
        :params => { :recipe => {  }})
    end
    
    it "redirects to resource(:recipes)" do
      @response.should redirect_to(resource(Recipe.first), :message => {:notice => "recipe was successfully created"})
    end
    
  end
end

