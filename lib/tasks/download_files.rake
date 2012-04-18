desc "Download files"
task :download_files => :environment do
  DataRetrieval.download_files
end

desc "Process artists"
task :process_artists => :environment do
  ProcessData.process_artists
end

desc "Process artworks"
task :process_artworks => :environment do
  ProcessData.process_artworks
end