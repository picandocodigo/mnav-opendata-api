desc "Download files"
task :download_files => :environment do
  Data::DataRetrieval.download_files
end

desc "Check if files have been updated"
task :check_updates => :environment do
  Data::DataRetrieval.check_file_updates
end