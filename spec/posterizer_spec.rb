require 'spec_helper.rb'

describe Posterizer do

  context "#parse" do
    it "returns a string" do
      Posterizer.parse("string").should be_a(String)
    end

    it "replaces tags with their content from settings" do
      Posterizer.parse("<h1>{Title}</h1>").should == "<h1>Test</h1>"
    end

    it "replaces {PostViews} tag with a random number" do
      Posterizer.parse("{PostViews}").to_i.should > 0
    end

    it "replaces {Pagination} tag with a pagination div" do
      Posterizer.parse("{block:Pagination/}").should include('<div class="pagination"')
    end

    it "replaces {block:EditBox/} tag with the default editbox html" do
      Posterizer.parse("{block:Posts}{block:EditBox/}{/block:Posts}").should include('<div class="editbox">')
    end

    it "replaces {DayOfMonth} and {ShortMonth} tags with appropriate values from post" do
      Posterizer.parse("{block:Posts}{DayOfMonth} {ShortMonth}{/block:Posts}").should include('10 Jun')
    end

  end

  context "#parse_post_block" do
    before do
      @html = %Q|
        {Title}
        {block:Posts}
          {Title}
        {/block:Posts}
      |
      @settings = YAML::load(File.read('settings.yml'))
    end

    it "replaces only elements within the block" do
      result = Posterizer.parse_post_block(@html, @settings)
      result.scan("{Title}").length.should == 1
      result.should include("This is a post about nothing")
    end

    it "returns the input if the element doesn't contain a post block" do
      Posterizer.parse_post_block("{Title}", @settings).should == "{Title}"
    end
  end
end
