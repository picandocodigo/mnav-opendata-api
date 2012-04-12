require 'spec_helper'
require 'process_data'

describe ProcessData do

  before do
    @valid_data = {
      :artist => "1;\"Brown, Emmet\";\"Emmet Brown\";1943;;\n",
      :artwork => "7;;\"El esgrimista\";\"\";\"Yeso patinado\";76,50;53;21;\n",
      :artwork_with_artist =>
        "3;1;\"Flux Capacitor\";\"1984\";\"Pixels\";66;140;43\n"
    }
  end

  describe 'Artist data processing' do
    it 'should create an artist' do
      prepare_valid_data("artist", @valid_data[:artist])
      artist = Artist.last
      artist.name.should eq("Brown, Emmet")
      artist.display_name.should eq("Emmet Brown")
    end
  end

  describe 'Artwork data processing' do
    it 'should create an artwork' do
      prepare_valid_data("artwork", @valid_data[:artwork])
      artwork = Artwork.last
      artwork.title.should eq("El esgrimista")
      artwork.museum_id.should eq(7)
      artwork.technique.should eq("Yeso patinado")
    end

    it 'should create an artwork for an artist' do
      prepare_valid_data("artist", @valid_data[:artist])
      prepare_valid_data("artwork", @valid_data[:artwork_with_artist])
      artwork = Artwork.last
      artwork.title.should eq("Flux Capacitor")
      artwork.museum_id.should eq(3)
      artwork.technique.should eq("Pixels")
    end
  end

  def prepare_valid_data(type, row)
    begin
      file = create_file(type)
      file.write(row)
      file.close
      ProcessData.process(type, file.path)
    rescue
      puts "Error"
    end
  end

  def create_file(type)
    File.new(Rails.root.join("./spec/lib/#{type}_test_data.csv"), "w+")
  end

  pending('should use mocks and stuff')
end
