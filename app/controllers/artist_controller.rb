# Public - Controller for incoming API requests.
# Renders JSON and XML.
class ArtistController < ApplicationController

  # Public - Get an artist info
  #
  # Example:
  #
  #   GET /artist/:id
  #
  def show
    @artist = Artist.find(params[:id])
    respond(@artist)
  end

  # Public - Get an artist's artworks
  #
  # Example:
  #   GET /artist/:id/artworks
  #
  def artist_artworks
    @artist = Artist.find(params[:id])
    respond(@artist.artworks)
  end


  # Public - Get artists according to search parameters
  #
  # Example:
  #
  #   GET /artists?name="Alejandro"
  #   GET /artists?birth[]=1900&birth[]=1950
  #
  def index
    if params[:birth]
      @artists = Artist.where(:birth => (params[:birth][0]..params[:birth][1]))
    end
    if params[:name]
      @artists = Artist.where("name like ?", "%" + params[:name] + "%")
    end
    respond(@artists)
  end

end
