require 'spec_helper'

describe Artwork do
  describe "save artwork" do
    it "should save a valid artwork" do
      museum_id = Artwork.order(:museum_id).last.museum_id + 1
      artist = Artist.last
      artwork = Artwork.create(:title => "Teenage Mutant Ninja Turtles", :museum_id => museum_id,
                  :artist => artist)
      assert artwork.persisted?
    end

    pending("test invalid artworks")
  end
end
