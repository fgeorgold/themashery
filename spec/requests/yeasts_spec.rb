require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a yeast exists" do
  Yeast.all.destroy!
  request(resource(:yeasts), :method => "POST", 
    :params => { :yeast => { :id => nil }})
end

describe "resource(:yeasts)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:yeasts))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of yeasts" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a yeast exists" do
    before(:each) do
      @response = request(resource(:yeasts))
    end
    
    it "has a list of yeasts" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Yeast.all.destroy!
      @response = request(resource(:yeasts), :method => "POST", 
        :params => { :yeast => { :id => nil }})
    end
    
    it "redirects to resource(:yeasts)" do
      @response.should redirect_to(resource(Yeast.first), :message => {:notice => "yeast was successfully created"})
    end
    
  end
end

describe "resource(@yeast)" do 
  describe "a successful DELETE", :given => "a yeast exists" do
     before(:each) do
       @response = request(resource(Yeast.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:yeasts))
     end

   end
end

describe "resource(:yeasts, :new)" do
  before(:each) do
    @response = request(resource(:yeasts, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@yeast, :edit)", :given => "a yeast exists" do
  before(:each) do
    @response = request(resource(Yeast.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@yeast)", :given => "a yeast exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Yeast.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @yeast = Yeast.first
      @response = request(resource(@yeast), :method => "PUT", 
        :params => { :article => {:id => @yeast.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@yeast))
    end
  end
  
end

