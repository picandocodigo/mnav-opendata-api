require 'spec_helper'
require 'nokogiri'

describe MnavController do

  describe "Artists JSON Responses" do
    before do
      @artist = create_artist
      get :artist, :id => @artist.id, :format => :json
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
      @artwork = create_artwork
      get :artwork, :id => @artwork.id, :format => :json
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
      @artist = create_artist_with_artwork
      get :artist_artworks, :id => @artist.id, :format => :json
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
      @artist = create_artist
      get :artist, :id => @artist.id, :format => :xml
      @xml = Nokogiri::XML(response.body)
    end

    it "should get a 200 OK response" do
      response.response_code.should == 200
    end

    it "should return XML" do
      response.content_type.should eq("application/xml")
    end

    it "should get an artist and have certain structure" do
      @xml.xpath("//id").inner_text.should eq(@artist.id.to_s)
      @xml.xpath("//name").should_not be nil
    end

  end

  describe "Artworks XML responses" do
    before do
      @artwork = create_artwork
      get :artwork, :id => @artwork.id, :format => :xml
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

  describe "Artist Artworks XML" do
    before do
      @artist = create_artist
      get :artist_artworks, :id => @artist.id, :format => :xml
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

  def create_artist
    artist = Artist.create(:museum_id => rand(10), :name => "Shigeru Miyamoto")
  end

  def create_artwork
    Artwork.create(:museum_id => rand(10), :title => "Super Mario Bros")
  end

  def create_artist_with_artwork
    artist = create_artist
    artist.artworks.create(:museum_id => rand(10), :title => "Super Mario Bros")
  end

  describe "get artists with search params" do
    before do
      Artist.create(:name => "Rafael", :museum_id => 1, :birth => 1930)
      Artist.create(:name => "Fernando", :museum_id => 2, :birth => 1920)
      Artist.create(:name => "Leonardo", :museum_id => 3, :birth => 1972)
      Artist.create(:name => "Donatello", :museum_id => 4, :birth => 1984)
      Artist.create(:name => "Michaelangelo", :museum_id => 5, :birth => 1916)
      Artist.create(:name => "Ed", :museum_id => 6, :birth => 1992)
      Artist.create(:name => "Alejandro", :museum_id => 7, :birth => 1935)
    end

    it "should get artists born between two dates" do
      get :artists, :birth => [1900,1950], :format => :json
      artists = JSON.parse(response.body)
      artists.size.should eq(4)
      artists.each do |artist|
        artist['birth'].should be < 1950
      end
    end

    it "should get artists with name search" do
      get :artists, :name => "and", :format => :json
      artists = JSON.parse(response.body)
      artists.size.should eq(2)
      artists.each do |artist|
        artist['name'].should match /and/
      end
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
      get :artworks, :technique => "cade", :format => :json
      artworks = JSON.parse(response.body)
      artworks.size.should eq(6)
      artworks.each do |artwork|
        artwork['technique'].should match /cade/
      end
    end

    it "should get artworks from a certain year" do
      get :artworks, :year => 1982, :format => :json
      artworks = JSON.parse(response.body)
      artworks.size.should eq(2)
    end

    it "should get artworks from a year range" do
      get :artworks, :year => [1900, 1950], :format => :json
      artworks = JSON.parse(response.body)
      artworks.each do |artwork|
        artwork['year'].should be_between(1900, 1950)
      end
    end
  end
end
