class ArtworksController < ApplicationController
  # Public - Get artwork
  #
  # Example:
  #   GET /artwork/:id
  #
  def show
    @artwork = Artwork.find(params[:id])
    respond(@artwork)
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


  # Public - Get Artworks according to search parameters
  #
  # Example
  #
  def index
    if params[:artist_id]
      @artworks = Artwork.where(:artist_id => params[:artist_id])
    end
    if params[:year]
      @artworks = if params[:year].is_a?(Array)
                    Artwork.where(:year => (params[:year][0]..params[:year][1]))
                  else
                    Artwork.where(:year => params[:year])
                  end
    end
    if params[:technique]
      @artworks = Artwork.where("technique like ?", "%" + params[:technique] + "%")
    end
    respond(@artworks)
  end

end
