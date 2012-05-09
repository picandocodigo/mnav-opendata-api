class AddArtowrkCountToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :artworks_count, :integer
    Artist.all.each do |artist|
      artist.update_attributes!(
        :artworks_count => artist.artworks.count
      )
    end
  end
end
