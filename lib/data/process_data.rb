require 'csv'

# Public - Process CSV files from MNAV
#
# This implementation is coupled to MNAV's csv files. Should be refactored in
# case we got data from another museum.
#
module ProcessData

  # Public - Save artists to the database from mnav's csv file
  #
  # file - String, path to the csv file or IO
  #
  # Example
  #
  #   ProcessData.process_artists('~/data/artists.csv')
  #
  # No return, logs errors in /log/data_processing_errors.log
  def self.process_artists(file = Rails.root.join('./public/data/artists.csv'))
    file = File.open(file, "r") if file.respond_to?(:to_path)
    CSV.new(file, :col_sep => ';').each do |row|
      artist = Artist.create(
        :museum_id => row[0],
        :name => row[1],
        :display_name => row[2],
        :birth => row[3],
        :death => row[4],
        :biography => row[5]
      )
      if artist.errors.any?
        artist.errors.each do |field, msg|
          log_error("#{Time.now} [Artist] - #{field} #{msg}")
          log_error("#{Time.now} [Artist Data] #{row}")
        end
      end
    end
  end

  # Public - Save artworks from MNAV's csv file
  #
  # file - String, path to the csv file or IO
  #
  # Example
  #
  #   ProcessData.process_artworks('~/data/artworks.csv')
  #
  # No return, logs errors in /log/data_processing_errors.log
  def self.process_artworks(file = Rails.root.join('./public/data/artworks.csv'))
    file = File.open(file, "r") if file.respond_to?(:to_path)
    CSV.new(file, :col_sep => ';').each do |row|
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
  end


  def self.process(type, file)
    case type
    when "artist"
      process_artists(file)
    when "artwork"
      process_artworks(file)
    else
      raise ArgumentError, "Invalid type, must be artist or artwork"
    end
  end

  private

  # Internal - Creates artwork with parameters from the csv file. Artworks can
  # belong to an artist, but we can have orphan artworks too.
  #
  def self.create_artwork(artwork_data)
    artwork = Artwork.new(artwork_data)
    artwork.artist = Artist.where(:museum_id => artwork_data[:museum_artist_id]).first
    artwork.save

    if artwork.errors.any?
      artwork.errors.each do |field, msg|
        log_error("#{Time.now} [Artwork] - #{field} #{msg}")
        log_error("#{Time.now} [Artwork Data] #{artwork_data}")
      end
    end
  end

  # Internal - Logs errors to a data file in /log
  def self.log_error msg
    logfile = File.open(Rails.root.join('./log/data_processing_errors.log'), 'a')
    Logger.new(logfile).error(msg)
  end

end
