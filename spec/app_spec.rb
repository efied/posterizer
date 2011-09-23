require 'spec_helper'

describe "service" do

  context "GET /" do
    it "returns success" do
      get "/"
      last_response.status.should == 200
      last_response.body.should_not be_empty
    end
  end
end
