module ControllersSpecHelper

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

end
