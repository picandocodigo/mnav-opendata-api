desc "Download files"
task :download_files => :environment do
  Data::DataRetrieval.download_files
end

desc "Download artists"
task :download_artists => :environment do
  data = YAML::load_file(Rails.root.join('../data/data.yaml'))
  entity = data['artists']
  Data::DataRetrieval.download_files({"artists" => entity})
end

desc "Download artworks"
task :download_artworks => :environment do
  data = YAML::load_file(Rails.root.join('../data/data.yaml'))
  entity = data['artworks']
  Data::DataRetrieval.download_files({"artworks" => entity})
end

desc "Check if files have been updated"
task :check_updates => :environment do
  Data::DataRetrieval.check_file_updates
end
