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
    respond_to do |format|
      format.json {render :json => @artist}
      format.xml {render :xml => @artist}
    end
  end

  # Public - Get an artist's artworks
  #
  # Example:
  #   GET /artist/:id/artworks
  #
  def artist_artworks
    @artist = Artist.find(params[:id])
    respond_to do |format|
      format.json {render :json => @artist.artworks}
      format.xml {render :xml => @artist.artworks}
    end
  end

  # Public - Get artwork
  #
  # Example:
  #   GET /artwork/:id
  #
  def artwork
    @artwork = Artwork.find(params[:id])
    respond_to do |format|
      format.json {render :json => @artwork}
      format.xml {render :xml => @artwork}
    end
  end

  # Public - Get artists according to certain parameters
  #
  # Example:
  #   
  def artists
    # TODO - Get artists by name search
    @artists = Artist.where(:birth => (params[:birth][0]..params[:birth][1]))
    respond_to do |format|
      format.json {render :json => @artists}
      format.xml {render :xml => @artists}
    end
  end

  # Pending:
  # get /artworks with params date, technique

end
