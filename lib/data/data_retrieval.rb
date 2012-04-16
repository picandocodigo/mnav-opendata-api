#!/usr/bin/ruby
require 'yaml'

# Public - Prepare data for processing
# This class retrieves data from the URL in data.yaml
class DataRetrieval
  # Public - Download files
  #
  # Platform dependant - uses wget and depends on OS. It's simpler this way and
  # I'm already being platform dependant on the file conversion.
  def download_files
    @data = YAML::load_file('data.yaml')
    @data.each do |data|
      data[1]['file'] = data[1]['url'].match(/\w*\.csv/).to_s
      `wget #{data[1]['url']} -O ../../public/data/#{data[1]['file']}`
    end
  end


  # Public - Convert csv files from ISO-8859-1 to UTF-8
  def convert_files
    @data.each do |k, value|
      name = value['name']
      file = value['file']
      shell_script = "iconv -f ISO-8859-1 -t UTF-8 ../../public/data/#{file} > #{name}"
      # Run the script on bash:
      `#{shell_script}`
    end
  end

end

data = DataRetrieval.new
data.download_files
data.convert_files
