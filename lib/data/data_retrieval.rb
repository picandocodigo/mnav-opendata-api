#!/usr/bin/ruby
require 'yaml'
require 'open-uri'

# Public - Prepare data for processing
# This class retrieves data from the URL in data.yaml
class DataRetrieval
  # Public - Download files
  #
  # Downloads files and converts them from ISO-8859-1 to UTF-8
  def download_files
    @data = YAML::load_file(Rails.root.join('./lib/data/data.yaml'))
    @data.each do |data|
      data[1]['file'] = data[1]['url'].match(/\w*\.csv/).to_s
      data_path = Rails.root.join("./public/data/#{data[1]['file']}")
      file = File.new("#{data_path}", "w+:utf-8")
      open("#{data[1]['url']}", "r:iso-8859-1") do |f|
        file.write(f.read)
      end
    end
    @result
  rescue => e
    logfile = File.open(Rails.root.join('./log/data_download_errors.log'), 'a')
    Logger.new(logfile).error(e)
  end

end
