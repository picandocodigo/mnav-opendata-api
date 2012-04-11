require 'csv'

module ProcessData

  def self.process_artists(file = Rails.root.join('./public/data/artists.csv'))
    begin
      CSV.foreach(file, :col_sep => ';') do |row|
        artist = Artist.create(
          :museum_id => row[0],
          :name => row[1],
          :display_name => row[2],
          :birth => row[3],
          :death => row[4],
          :biography => row[5]
        )
        if artist.errors
          artist.errors.each do |field, msg|
            log("[Artist] - museum id: #{artist.museum_id} - #{field} #{msg}")
          end
        end
      end
    rescue Exception
      Rails.logger.error "Exception! #{$!} - museum_id: #{row[0]}"
    end
  end

  def self.process_artworks(file = Rails.root.join('./public/data/artworks.csv'))
    CSV.foreach(file, :col_sep => ';') do |row|
      artwork_data = {
        :museum_id => row[0],
        :museum_artist_id => row[1],
        :title => row[2],
        :year => row[3],
        :technique => row[4],
        :height => row[5],
        :width => row[6],
        :depth => row[7]
      }
      require 'debugger'
      debugger
      if row[1].nil? || row[1].empty?
        artwork = Artwork.new(artwork_data)
      else
        artist = Artist.where("museum_id = #{row[1]}").first
        artwork = artist.artworks.create(artwork_data)
      end

      if artwork.errors
        artwork.errors.each do |field, msg|
          log("[Artwork] - museum id: #{row[0]} - #{field} #{msg}")
        end
      end
    end
  end

  private
  def self.log msg
    logfile = File.open(Rails.root.join('./log/data_processing_errors.log'), 'a')
    Logger.new(logfile).error(msg)
  end

end
