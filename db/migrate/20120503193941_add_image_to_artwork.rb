class AddImageToArtwork < ActiveRecord::Migration
  def change
    add_column :artworks, :image_url, :string
    Artwork.all.each do |artwork|
      artwork.update_attributes!(
        :image_url =>
          "http://www.mnav.gub.uy/obras/mnavXX#{artwork.museum_id}.jpg"
      )
    end
  end
end
