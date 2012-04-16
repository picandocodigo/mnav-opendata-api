# Public - Controller for incoming API requests.
# Renders JSON and XML.
class MnavController < ApplicationController

  # Public - Get an artist info
  #
  # Example:
  #
  #   GET /artist/:id
  #
  def artist
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
    respond(@artist)
  end

  # Public - Get artwork
  #
  # Example:
  #   GET /artwork/:id
  #
  def artwork
    @artwork = Artwork.find(params[:id])
    respond(@artwork)
  end

  # Public - Get artists according to search parameters
  #
  # Example:
  #
  #   GET /artists?name="Alejandro"
  #   GET /artists?date[]=1900&date[]=1950
  #
  def artists
    if params[:birth]
      @artists = Artist.where(:birth => (params[:birth][0]..params[:birth][1]))
    end
    if params[:name]
      @artists = Artist.where("name like ?", "%" + params[:name] + "%")
    end
    respond(@artists)
  end

  # Public - Get Artworks according to search parameters
  #
  # Example
  #
  def artworks
    if params[:year]
      @artworks = Artwork.where(:year => params[:year])
    end
    if params[:technique]
      @artworks = Artwork.where("technique like ?", "%" + params[:technique] + "%")
    end
    respond(@artworks)
  end

  def respond(elem)
    respond_to do |format|
      format.json {render :json => elem}
      format.xml {render :xml => elem}
    end
  end

end
