require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a batch exists" do
  request(resource(:batches), :method => "POST", 
    :params => { :batch => {  }})
end

describe "resource(:batches)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:batchs))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of speakers" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a batch exists" do
    before(:each) do
      @response = request(resource(:batches))
    end
    
    it "has a list of batches" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      @response = request(resource(:batches), :method => "POST", 
        :params => { :batch => {  }})
    end
    
    it "redirects to resource(:batches)" do
      @response.should redirect_to(resource(Batch.first), :message => {:notice => "batch was successfully created"})
    end
    
  end
end

