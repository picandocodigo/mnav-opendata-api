class AddYearToArtwork < ActiveRecord::Migration
  def up
    add_column :artworks, :year, :integer
  end

  def down
    remove_column :artworks, :year
  end
end
