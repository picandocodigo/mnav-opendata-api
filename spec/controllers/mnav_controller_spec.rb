require 'spec_helper'

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
end
