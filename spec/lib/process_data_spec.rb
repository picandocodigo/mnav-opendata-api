require 'spec_helper'
require 'process_data'

describe ProcessData do

  let :artist_data do
    StringIO.new("1;\"Brown, Emmet\";\"Emmet Brown\";1943;;\n")
  end

  let :artists_data do
    StringIO.new(<<-CSV.strip_heredoc)
      1;"Brown, Emmet";"Emmet Brown";1943;;
      2;"Marty McFly";"McFly Marty";1970;;
      3;"Johns, Geoff";"Geoff Johns";1973;;
      4;"Lee, Stan";"Stan Lee";1922;;
    CSV
  end

  let :invalid_artist_data do
    StringIO.new(";")
  end

  let :artwork_data do
    StringIO.new("7;;\"El esgrimista\";\"\";\"Yeso patinado\";76,50;53;21;\n")
  end

  let :artwork_with_artist_data do
    StringIO.new("3;1;\"Flux Capacitor\";\"1984\";\"Pixels\";66;140;43\n")
  end

  let :artworks_data do
    StringIO.new(<<-CSV.strip_heredoc)
      1;;"DeLorean";"1985";"Aluminium";231;123;;
      2;1;"Mr Fusion";"2015";"Banana";24;65;75;
      3;1;"Flux Capacitor";"1955";"Metal";56;76;99;
    CSV
  end

  it "can't process something that isn't an artist or an artwork" do
    expect { ProcessData.process("lettuce", double) }.to raise_error(ArgumentError)
  end

  describe 'Artist valid data processing' do
    it 'should create an artist' do
      ProcessData.process("artist", artist_data)
      artist = Artist.last
      artist.name.should eq("Brown, Emmet")
      artist.display_name.should eq("Emmet Brown")
    end

    it 'should create several artists' do
      expect {
        ProcessData.process("artist", artists_data)
      }.to change { Artist.count }.by(line_count(artists_data))
    end
  end

  describe 'Artwork valid data processing' do
    it 'should create an artwork' do
      ProcessData.process("artwork", artwork_data)
      artwork = Artwork.last
      artwork.title.should eq("El esgrimista")
      artwork.museum_id.should eq(7)
      artwork.technique.should eq("Yeso patinado")
    end

    it 'should create an artwork for an artist' do
      ProcessData.process("artist", artist_data)
      ProcessData.process("artwork", artwork_with_artist_data)
      artwork = Artwork.last
      artwork.title.should eq("Flux Capacitor")
      artwork.museum_id.should eq(3)
      artwork.technique.should eq("Pixels")
    end

    it 'should create severl artworks' do
      ProcessData.process("artist", artist_data)
      expect {
        ProcessData.process("artwork", artworks_data)
      }.to change { Artwork.count }.by(line_count(artworks_data))
      Artwork.all.map(&:title).should =~ ["DeLorean", "Mr Fusion", "Flux Capacitor"]
    end
  end

  describe "Artist invalid data processing" do
    it "should not create an artist with invalid data" do
      expect {
        ProcessData.process("artist", invalid_artist_data)
      }.to_not change { Artist.count }
    end
  end

  def line_count(file)
    file.lines.to_a.size
  ensure
    file.rewind
  end
end
