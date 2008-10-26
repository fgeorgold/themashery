require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a hop exists" do
  Hop.all.destroy!
  request(resource(:hops), :method => "POST", 
    :params => { :hop => { :id => nil }})
end

describe "resource(:hops)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:hops))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of hops" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a hop exists" do
    before(:each) do
      @response = request(resource(:hops))
    end
    
    it "has a list of hops" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Hop.all.destroy!
      @response = request(resource(:hops), :method => "POST", 
        :params => { :hop => { :id => nil }})
    end
    
    it "redirects to resource(:hops)" do
      @response.should redirect_to(resource(Hop.first), :message => {:notice => "hop was successfully created"})
    end
    
  end
end

describe "resource(@hop)" do 
  describe "a successful DELETE", :given => "a hop exists" do
     before(:each) do
       @response = request(resource(Hop.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:hops))
     end

   end
end

describe "resource(:hops, :new)" do
  before(:each) do
    @response = request(resource(:hops, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@hop, :edit)", :given => "a hop exists" do
  before(:each) do
    @response = request(resource(Hop.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@hop)", :given => "a hop exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Hop.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @hop = Hop.first
      @response = request(resource(@hop), :method => "PUT", 
        :params => { :article => {:id => @hop.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@hop))
    end
  end
  
end

