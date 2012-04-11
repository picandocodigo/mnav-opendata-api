class MnavController < ApplicationController
  def artist
    @artist = Artist.find(params[:id])
    respond_to do |format|
      format.json {render :json => @artist}
      format.xml {render :xml => @artist}
    end
  end

  def artist_artworks
    @artist = Artist.find(params[:id])
    respond_to do |format|
      format.json {render :json => @artist.artworks}
      format.xml {render :xml => @artist.artworks}
    end
  end

  def artwork
    @artwork = Artwork.find(params[:id])
    respond_to do |format|
      format.json {render :json => @artwork}
      format.xml {render :xml => @artwork}
    end
  end

  # Pending:
  # get /artists with date params, search by name
  # get /artworks with params date, technique
end
