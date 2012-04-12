require 'spec_helper'
require 'process_data'

describe ProcessData do

  before do
    @data = {
      :artist => "1;\"Brown, Emmet\";\"Emmet Brown\";1943;;\n",
      :artists => "1;\"Brown, Emmet\";\"Emmet Brown\";1943;;\n" +
        "2;\"Marty McFly\";\"McFly Marty\";1970;;\n" +
        "3;\"Johns, Geoff\";\"Geoff Johns\";1973;;\n" +
        "4;\"Lee, Stan\";\"Stan Lee\";1922;;\n",
      :artist_invalid => ";",
      :artwork => "7;;\"El esgrimista\";\"\";\"Yeso patinado\";76,50;53;21;\n",
      :artwork_with_artist =>
        "3;1;\"Flux Capacitor\";\"1984\";\"Pixels\";66;140;43\n",
    }
  end

  describe 'Artist valid data processing' do
    it 'should create an artist' do
      prepare_data("artist", @data[:artist])
      artist = Artist.last
      artist.name.should eq("Brown, Emmet")
      artist.display_name.should eq("Emmet Brown")
    end

    it 'should create several artists' do
      prepare_data("artist", @data[:artists])
      artists = Artist.all
      artists.count.should eq(@data[:artists].scan("\n").size)
    end
  end

  describe 'Artwork valid data processing' do
    it 'should create an artwork' do
      prepare_data("artwork", @data[:artwork])
      artwork = Artwork.last
      artwork.title.should eq("El esgrimista")
      artwork.museum_id.should eq(7)
      artwork.technique.should eq("Yeso patinado")
    end

    it 'should create an artwork for an artist' do
      prepare_data("artist", @data[:artist])
      prepare_data("artwork", @data[:artwork_with_artist])
      artwork = Artwork.last
      artwork.title.should eq("Flux Capacitor")
      artwork.museum_id.should eq(3)
      artwork.technique.should eq("Pixels")
    end
  end

  describe "Artist invalid data processing" do
    it "should not creat an artist with invalid data" do
      prepare_data("artist",@data[:artist_invalid])
    end
  end

  def prepare_data(type, row)
    begin
      file = File.new(Rails.root.join("./spec/lib/#{type}_test_data.csv"), "w+")
      file.write(row)
      file.close
      ProcessData.process(type, file.path)
    rescue
      puts "Error #{$!}"
    end
  end

end
