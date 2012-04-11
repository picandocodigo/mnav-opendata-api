require 'spec_helper'
require 'nokogiri'

describe MnavController do

  describe "Artists JSON Responses" do
    before do
      get :artist, :id => 914, :format => :json
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should get an artist and have certain structure" do
      json_response = JSON.parse(response.body)
      json_response.should have_key("name")
      json_response.should have_key("museum_id")
      json_response.should have_key("display_name")
    end

  end

  describe "Artworks JSON responses" do
    before do
      get :artwork, :id => 1, :format => :json
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should get an artwork and have certain structure" do
      json_response = JSON.parse(response.body)
      json_response.should have_key("title")
      json_response.should have_key("museum_id")
      json_response.should have_key("museum_artist_id")
    end
  end

  describe "Artist Artworks JSON" do
    before do
      get :artist_artworks, :id => 92, :format => :json
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should get an artist artworks" do
      json_response = JSON.parse(response.body)
      json_response.should have_at_least(1).items
    end
  end

  describe "Artists XML Responses" do
    before do
      @id = 914
      get :artist, :id => @id, :format => :xml
      @xml = Nokogiri::XML(response.body)
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should return XML" do
      response.content_type.should eq("application/xml")
    end

    it "should get an artist and have certain structure" do
      @xml.xpath("//id").inner_text.should eq(@id.to_s)
      @xml.xpath("//name").should_not be nil
    end

  end

  describe "Artworks XML responses" do
    before do
      @id = 1
      get :artwork, :id => @id, :format => :xml
      @xml = Nokogiri::XML(response.body)
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should return XML" do
      response.content_type.should eq("application/xml")
    end

    it "should get an artwork and have certain structure" do
      @xml.xpath("//id").inner_text.should eq(@id.to_s)
      @xml.xpath("//title").should_not be nil
    end
  end

  describe "Artist Artworks XML" do
    before do
      @id = 92
      get :artist_artworks, :id => @id, :format => :xml
      @xml = Nokogiri::XML(response.body)
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should return XML" do
      response.content_type.should eq("application/xml")
    end


    it "should get an artist artworks" do
      @xml.xpath("//artwork").each do |artwork_node|
        artwork_node.xpath("//title").should_not be nil
        artwork_node.xpath("//id").should_not be nil
        artwork_node.xpath("//museum_id").should_not be nil
      end
    end
  end

end
