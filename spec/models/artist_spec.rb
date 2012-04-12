require 'spec_helper'

describe Artist do
  describe "saving artist" do
    before do
      @id = 999999
    end

    it "should save a valid artist" do
      museum_id = @id
      artist = Artist.create(:name => "Greg Graffin", :museum_id => museum_id)
      assert artist.persisted?
    end
  end

  describe "checking artist museum_id uniqueness" do
    before do
      Artist.create(:name => "Joss Whedon", :museum_id => @id)
    end

    it "should not save an artist with not-unique museum id" do
      museum_id = @id
      artist = Artist.create(:name => "Steve Rogers", :museum_id => museum_id)
      artist.persisted?.should be false
    end

    it "should not save an artist without name" do
      museum_id = 99999999999
      artist = Artist.create(:museum_id => museum_id)
      artist.persisted?.should be false
    end
  end
end
