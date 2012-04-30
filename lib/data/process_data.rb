# encoding: utf-8

require 'csv'

# Public - Process CSV files from MNAV
#
# This implementation is coupled to MNAV's csv files. Should be refactored in
# case we got data from another museum.
#
class Data
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
    def self.process_artists(file)
      CSV.parse(file.string, :col_sep => ';', :row_sep => "\n").each do |row|
        artist =
          Artist.create(
                        :museum_id => row[0],
                        :name => row[1],
                        :display_name => row[2],
                        :birth => row[3],
                        :death => row[4],
                        :biography => row[5]
                        )
        if artist.errors.any?
          artist.errors.each do |field, msg|
            self.log_error("[Artist] - #{field} #{msg}")
            self.log_error("[Artist Data] #{row}")
          end
        end
      end
    rescue => e
      self.log_error(e)
    ensure
      file.close
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
    def self.process_artworks(file)
      CSV.parse(file.string, :col_sep => ';').each do |row|
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
    rescue => e
      self.log_error(e)
    ensure
      file.close
    end


    # Public - Wrapper for process_artists and process_artworks
    #
    # type - String, can be "artist" or "artwork"
    #
    # Example
    #
    #   ProcessData.process('artist', '~/data/artwork.csv')
    def self.process(type, file)
      case type
      when "artists"
        process_artists(file)
      when "artworks"
        process_artworks(file)
      else
        raise ArgumentError, "Invalid type, must be artists or artworks"
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
          self.log_error("[Artwork] - #{field} #{msg}")
          self.log_error("[Artwork Data] #{artwork_data}")
        end
      end
    end

    # Internal - Logs errors to a data file in /log
    def self.log_error msg
      logfile = File.open(Rails.root.join('./log/data_processing_errors.log'), 'a')
      Logger.new(logfile).error("#{Time.now} - #{msg}")
    end

  end
end
