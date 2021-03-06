# Public - Controller for Artists requests.
# Renders JSON and XML.
class ArtistsController < ApplicationController

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
      @artists = Artist.where("lower(name) LIKE :name",
                              {:name => "%" + params[:name].downcase + "%"}
                              )
    end
    respond(@artists)
  end

  def top_artists
    limit = params[:limit] ? params[:limit].to_i - 1 : 5
    @artists = Artist.find(:all, :order => "artworks_count DESC")[0..limit]
    respond(@artists)
  end

end
