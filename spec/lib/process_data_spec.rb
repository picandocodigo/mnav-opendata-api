require 'spec_helper'
require 'process_data'

describe ProcessData do
  describe 'pass test' do
    it "should pass" do
      assert true
    end
  end

  describe 'Artist data processing' do
    it 'should create an artist' do
      test_file = File.new(Rails.root.join("./spec/lib/artist_test_data.csv"),  "w+")
      id = Artist.order("museum_id").last.museum_id + 1
      test_file.write("#{id};\"Brown, Emmet\";\"Emmet Brown\";1943;;\n");
      test_file.close
      ProcessData.process_artists(test_file.path)
      artist = Artist.last
      artist.name.should eq("Brown, Emmet")
      artist.display_name.should eq("Emmet Brown")
    end
  end

  describe 'Artwork data processing' do
    it 'should create an artwork for an artist' do
      pending('test create an artwork')
    end
    
    it 'should create an artwork for an artist' do
      pending('test create an artwork related to an artist')
    end
  end

  pending('should use mocks and stuff')
end
