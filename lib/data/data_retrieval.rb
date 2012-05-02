# encoding: utf-8
require 'yaml'
require 'open-uri'
require 'date'
require 'stringio'
require 'data/process_data'
require 'net/http'

# Public - Prepare data for processing
# This class retrieves data from the URL in data.yaml
class Data
  module DataRetrieval

    # Public - Download files
    #
    # Downloads files and converts them from ISO-8859-1 to UTF-8
    #
    def self.download_files(entity = nil)
      config = entity ? entity : self.load_data_yaml
      config.each do |entity|
        file = self.download(entity[1]['url'])
        entity[1]['last_modified'] = DateTime.now.strftime("%Y/%m/%d")
        ProcessData.process(entity[0], file)
        self.update_last_modified(entity)
      end
    rescue => e
      self.log(e)
    end

    # Public - Check if the files have been changed on the website and download
    # them if they were
    def self.check_file_updates
      config = self.load_data_yaml
      config.each do |entity|
        if needs_update(entity)
          self.download_files(entity)
        else
          self.log("No update necessary for #{entity[0]}")
        end
      end
    end

    private

    # Internal
    def self.download(url)
      file = StringIO.open("", "w+:utf-8")
      file.write open(url, "r:iso-8859-1").read.gsub(/\r/, "")
      file
    end

    def self.load_data_yaml
      YAML::load_file(Rails.root.join('./lib/data/data.yaml'))
    end

    # Internal - update last modified date on config file
    def self.update_last_modified(entity)
      yaml = self.load_data_yaml
      yaml[entity[0]] = entity[1]
      File.open(Rails.root.join('./lib/data/data.yaml'), 'w') do |f|
        f.write(yaml.to_yaml)
      end
    end

    def self.needs_update(entity)
      uri = URI(entity[1]['url'])
      remote_date = Date.parse(Net::HTTP.get_response(uri).
                               get_fields("Last-Modified")[0])
        .strftime('%Y/%m/%d')
      return Date.parse(entity[1]['last_modified']) < Date.parse(remote_date)
    end

    def self.log(e)
      logfile = File.open(Rails.root.join('./log/data_download_errors.log'), 'a')
      Logger.new(logfile).error("#{Time.now} - #{e}")
    end

  end
end
