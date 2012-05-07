class AddThumbnailImageToArtwork < ActiveRecord::Migration
  def change
    add_column :artworks, :image_thumbnail_url, :string
    Artwork.all.each do |artwork|
      artwork.update_attributes!(
        :image_thumbnail_url =>
        "http://www.mnav.gub.uy/obras/mnav#{artwork.museum_id}.jpg"
      )
    end
  end
end
