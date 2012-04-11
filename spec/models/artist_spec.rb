require 'spec_helper'

describe Artist do
  describe "saving artist" do
    it "should save a valid artist" do
      museum_id = Artist.order(:museum_id).last.museum_id + 1
      artist = Artist.create(:name => "Greg Graffin", :museum_id => museum_id)
      assert artist.persisted?
    end

    it "should not save an artist with not-unique museum id" do
      museum_id = Artist.first.museum_id
      artist = Artist.create(:name => "Steve Rogers", :museum_id => museum_id)
      artist.persisted?.should be false
    end

    it "should not save an artist without name" do
      museum_id = Artist.order(:museum_id).last.museum_id + 1
      artist = Artist.create(:museum_id => museum_id)
      artist.persisted?.should be false
    end
  end
end
