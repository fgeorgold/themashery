require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a adjunct exists" do
  Adjunct.all.destroy!
  request(resource(:adjuncts), :method => "POST", 
    :params => { :adjunct => { :id => nil }})
end

describe "resource(:adjuncts)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:adjuncts))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of adjuncts" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a adjunct exists" do
    before(:each) do
      @response = request(resource(:adjuncts))
    end
    
    it "has a list of adjuncts" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Adjunct.all.destroy!
      @response = request(resource(:adjuncts), :method => "POST", 
        :params => { :adjunct => { :id => nil }})
    end
    
    it "redirects to resource(:adjuncts)" do
      @response.should redirect_to(resource(Adjunct.first), :message => {:notice => "adjunct was successfully created"})
    end
    
  end
end

describe "resource(@adjunct)" do 
  describe "a successful DELETE", :given => "a adjunct exists" do
     before(:each) do
       @response = request(resource(Adjunct.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:adjuncts))
     end

   end
end

describe "resource(:adjuncts, :new)" do
  before(:each) do
    @response = request(resource(:adjuncts, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@adjunct, :edit)", :given => "a adjunct exists" do
  before(:each) do
    @response = request(resource(Adjunct.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@adjunct)", :given => "a adjunct exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Adjunct.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @adjunct = Adjunct.first
      @response = request(resource(@adjunct), :method => "PUT", 
        :params => { :article => {:id => @adjunct.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@adjunct))
    end
  end
  
end

