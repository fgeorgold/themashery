require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a fermentable exists" do
  Fermentable.all.destroy!
  request(resource(:fermentables), :method => "POST", 
    :params => { :fermentable => { :id => nil }})
end

describe "resource(:fermentables)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:fermentables))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of fermentables" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a fermentable exists" do
    before(:each) do
      @response = request(resource(:fermentables))
    end
    
    it "has a list of fermentables" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Fermentable.all.destroy!
      @response = request(resource(:fermentables), :method => "POST", 
        :params => { :fermentable => { :id => nil }})
    end
    
    it "redirects to resource(:fermentables)" do
      @response.should redirect_to(resource(Fermentable.first), :message => {:notice => "fermentable was successfully created"})
    end
    
  end
end

describe "resource(@fermentable)" do 
  describe "a successful DELETE", :given => "a fermentable exists" do
     before(:each) do
       @response = request(resource(Fermentable.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:fermentables))
     end

   end
end

describe "resource(:fermentables, :new)" do
  before(:each) do
    @response = request(resource(:fermentables, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@fermentable, :edit)", :given => "a fermentable exists" do
  before(:each) do
    @response = request(resource(Fermentable.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@fermentable)", :given => "a fermentable exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Fermentable.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @fermentable = Fermentable.first
      @response = request(resource(@fermentable), :method => "PUT", 
        :params => { :article => {:id => @fermentable.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@fermentable))
    end
  end
  
end

