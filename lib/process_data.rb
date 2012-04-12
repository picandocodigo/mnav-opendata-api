require 'csv'

# Public - Process CSV files from MNAV
#
# This implementation is coupled to MNAV's csv files. Should be refactored in
# case we got data from another museum.
#
module ProcessData

  # Public - Save artists to the database from mnav's csv file
  #
  # file - String, path to the csv file
  #
  # Example
  #
  #   ProcessData.process_artists('~/data/artists.csv')
  #
  # No return, logs errors in /log/data_processing_errors.log
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
            log_error("[Artist] - museum id: #{artist.museum_id} - #{field} #{msg}")
          end
        end
      end
    rescue Exception
      log_error "[Artist] Exception: #{$!} - museum_id: #{row[0]}"
    end
  end

  # Public - Save artworks from MNAV's csv file
  #
  # file - String, path to the csv file
  #
  # Example
  #
  #   ProcessData.process_artworks('~/data/artworks.csv')
  #
  # No return, logs errors in /log/data_processing_errors.log
  def self.process_artworks(file = Rails.root.join('./public/data/artworks.csv'))
    begin
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
        create_artwork(artwork_data)
      end
    rescue Exception
      log_error "[Artwork] Exception: #{$!} - museum_id: #{row[0]}"
    end
  end


  def self.process(type, file)
    case type
    when "artist"
      process_artists(file)
    when "artwork"
      process_artworks(file)
    end
  end

  private

  # Internal - Creates artwork with parameters from the csv file. Artworks can
  # belong to an artist, but we can have orphan artworks too.
  #
  def self.create_artwork(artwork_data)
    if artwork_data[:museum_artist_id].blank? || artwork_data[:museum_artist_id].empty? ||
        artwork_data[:museum_artist_id].nil?
      artwork = Artwork.create(artwork_data)
    else
      artist = Artist.where(:museum_id => artwork_data[:museum_artist_id]).first
      artwork = artist.artworks.create(artwork_data)
    end

    if artwork.errors
      artwork.errors.each do |field, msg|
        log_error("[Artwork] - museum id: #{artist_data[:museum_artist_id]} - #{field} #{msg}")
      end
    end
  end

  # Internal - Logs errors to a data file in /log
  def self.log_error msg
    logfile = File.open(Rails.root.join('./log/data_processing_errors.log'), 'a')
    Logger.new(logfile).error(msg)
  end

end
