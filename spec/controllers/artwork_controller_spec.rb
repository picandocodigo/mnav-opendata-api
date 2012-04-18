require 'spec_helper'

describe ArtworkController do

  def create_artwork
    Artwork.create(:museum_id => rand(10), :title => "Super Mario Bros")
  end

  describe "Artworks JSON responses" do
    before do
      @artwork = create_artwork
      get :show, :id => @artwork.id, :format => :json
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

  describe "Artworks XML responses" do
    before do
      @artwork = create_artwork
      get :show, :id => @artwork.id, :format => :xml
      @xml = Nokogiri::XML(response.body)
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should return XML" do
      response.content_type.should eq("application/xml")
    end

    it "should get an artwork and have certain structure" do
      @xml.xpath("//id").inner_text.should eq(@artwork.id.to_s)
      @xml.xpath("//title").should_not be nil
    end
  end

  describe "get artworks with search params" do
    before do
      Artwork.create(:title => "Joust", :museum_id => 1, :technique => "Arcade", :year => 1982)
      Artwork.create(:title => "1943", :museum_id => 2, :technique => "Arcade", :year => 1987)
      Artwork.create(:title => "Qbert", :museum_id => 3, :technique => "Arcade", :year => 1982)
      Artwork.create(:title => "Monkey Island", :museum_id => 4, :technique => "PC", :year => 1990)
      Artwork.create(:title => "Tetris", :museum_id => 5, :technique => "Arcade")
      Artwork.create(:title => "Golden Axe", :museum_id => 6, :technique => "Arcade")
      Artwork.create(:title => "Street Fighter II", :museum_id => 7, :technique => "Arcade")
      Artwork.create(:title => "River City Ransom", :museum_id => 8, :technique => "NES")
      Artwork.create(:title => "Super Mario Kart", :museum_id => 9, :technique => "SNES", :year => 1992)
      Artwork.create(:title => "River City Ransom", :museum_id => 10, :technique => "NES")
      Artwork.create(:title => "River City Ransom", :museum_id => 11, :technique => "NES")
    end

    it "should get artworks with certain technique" do
      get :index, :technique => "cade", :format => :json
      artworks = JSON.parse(response.body)
      artworks.size.should eq(6)
      artworks.each do |artwork|
        artwork['technique'].should match /cade/
      end
    end

    it "should get artworks from a certain year" do
      get :index, :year => 1982, :format => :json
      artworks = JSON.parse(response.body)
      artworks.size.should eq(2)
    end

    it "should get artworks from a year range" do
      get :index, :year => [1900, 1950], :format => :json
      artworks = JSON.parse(response.body)
      artworks.each do |artwork|
        artwork['year'].should be_between(1900, 1950)
      end
    end
  end
end
