require 'rails_helper'

describe Artwork do
  describe "save artwork" do
    it "should save a valid artwork" do
      museum_id = 1
      artist = Artist.create(:museum_id => 2, :name => "Kevin Eastman")
      artwork = Artwork.create(:title => "Teenage Mutant Ninja Turtles", :museum_id => museum_id,
                  :artist => artist)
      assert artwork.persisted?
    end

    it "should save a valid artwork without artist" do
      museum_id = 1
      artwork = Artwork.create(:title => "", :museum_id => museum_id)
      expect(artwork.persisted?).to be false
    end

    it "should not save an invalid artwork" do
      museum_id = 1
      artist = Artist.create(:museum_id => 1, :name => "Jeff Atwood")
      artwork = Artwork.create(:artist => artist)
      assert artwork.errors
    end
  end
end
