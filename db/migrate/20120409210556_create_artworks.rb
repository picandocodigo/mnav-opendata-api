class CreateArtworks < ActiveRecord::Migration
  def up
    create_table :artworks do |t|
      t.integer    :museum_id
      t.integer    :museum_artist_id
      t.string     :title
      t.string     :technique
      t.decimal    :height
      t.decimal    :width
      t.decimal    :depth
      t.references :artist
      t.timestamps
    end
  end

  def down
    drop_table :artworks
  end
end
