require 'rails_helper'
require 'nokogiri'
require 'controllers_spec_helper'


RSpec.describe ArtistsController, :type => :controller do
  include ControllersSpecHelper

  describe "Artists JSON Responses" do
    before do
      @artist = create_artist
      get :show, :id => @artist.id, :format => :json
    end

    it "should get a 200 OK response" do
      expect(response).to have_http_status(200)
    end

    it "should get an artist and have certain structure" do
      json_response = JSON.parse(response.body)
      expect(json_response).to have_key("name")
      expect(json_response).to have_key("museum_id")
      expect(json_response).to have_key("display_name")
    end
  end

  describe "Artists XML Responses" do
    before do
      @artist = create_artist
      get :show, :id => @artist.id, :format => :xml
      @xml = Nokogiri::XML(response.body)
    end

    it "should get a 200 OK response" do
      expect(response).to have_http_status(200)
    end

    it "should return XML" do
      expect(response.content_type).to eq("application/xml")
    end

    it "should get an artist and have certain structure" do
      expect(@xml.xpath("//id").inner_text).to eq(@artist.id.to_s)
      expect(@xml.xpath("//name")).to_not be nil
    end

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
      get :index, :birth => [1900,1950], :format => :json
      artists = JSON.parse(response.body)
      expect(artists.size).to eq(4)
      artists.each do |artist|
        expect(artist['birth']).to be < 1950
      end
    end

    it "should get artists with name search" do
      get :index, :name => "and", :format => :json
      artists = JSON.parse(response.body)
      expect(artists.size).to eq(2)
      artists.each do |artist|
        expect(artist['name']).to match /and/
      end
    end

  end


end
