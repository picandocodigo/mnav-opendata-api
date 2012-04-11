class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.integer :museum_id
      t.string :name
      t.string :display_name
      t.integer :birth
      t.integer :death
      t.text :biography

      t.timestamps
    end
  end
end
