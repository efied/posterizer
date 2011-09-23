require 'spec_helper.rb'

describe Posterizer do

  context "#parse" do
    it "returns a string" do
      Posterizer.parse("string").should be_a(String)
    end

    it "replaces tags with their content from settings" do
      Posterizer.parse("<h1>{Title}</h1>").should == "<h1>Test</h1>"
    end
  end
end
