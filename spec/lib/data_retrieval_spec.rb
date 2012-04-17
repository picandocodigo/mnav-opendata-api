require 'spec_helper'
require 'data_retrieval'

describe DataRetrieval do
  def get_complete_path(path)
    Rails.root.join(path)
  end

  describe "Files download" do
    it "should download files" do
      data = DataRetrieval.new
      data.download_files
      assert File.exists?(get_complete_path("./public/data/artistas.csv"))
    end

    # TODO - Check out VCR
    it "should have valid downloaded data" do
      data = DataRetrieval.new
      data.download_files
      line = File.readlines(get_complete_path("./public/data/artistas.csv"))[0]
      line.should eq("15;\"Abougit, Marcelo(Marcel)\";\"Marcelo Abougit\";1900;;\n")
    end

  end


end
