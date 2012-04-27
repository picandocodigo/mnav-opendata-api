#!/usr/bin/ruby
require 'yaml'
require 'open-uri'
require 'date'

# Public - Prepare data for processing
# This class retrieves data from the URL in data.yaml
module DataRetrieval

  # Public - Download files
  #
  # Downloads files and converts them from ISO-8859-1 to UTF-8
  def self.download_files
    config = self.load_data
    config.each do |entity|
      self.download(entity)
    end
  rescue => e
    self.log(e)
  end

  # Public - Check if the files have been changed on the website and download
  # them if they were
  def self.check_file_updates
    config = self.load_data
    config.each do |entity|
      remote_date = open(entity[1]['url']).last_modified
      if remote_date > entity[1]['last_modified']
        self.download_file(entity[1]['url'], )
      else
        log("#{entity[0]} - No update necessary")
      end
    end
  rescue => e
    self.log(e)
  end

  private

  def self.download(entity)
    entity[1]['file'] = entity[1]['url'].match(/\w*\.csv/).to_s
    data_path = Rails.root.join("./public/data/#{entity[1]['file']}")
    file = File.new("#{data_path}", "w+:utf-8")

    open(entity[1]['url'], "r:iso-8859-1") do |f|
      file.write(f.read)
      self.update_last_modified(entity[0], f.last_modified)
    end
  end

  def self.load_data
    YAML::load_file(Rails.root.join('./lib/data/data.yaml'))
  end

  # Internal - update last modified date on config file
  def self.update_last_modified(entity, last_modified)
    yaml = self.load_data
    require 'debugger'; debugger
    yaml[entity]['last_modified'] = Date.parse(last_modified.strftime('%Y/%m/%d'))
    File.open(Rails.root.join('./lib/data/data.yaml'), 'w') do |f|
      f.write(yaml.to_yaml)
    end
  end

  def self.log(e)
    logfile = File.open(Rails.root.join('./log/data_download_errors.log'), 'a')
    Logger.new(logfile).error(e)
  end

end
