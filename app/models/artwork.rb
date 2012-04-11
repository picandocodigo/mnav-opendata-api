class Artwork < ActiveRecord::Base
  belongs_to :artist
  validates :museum_id, :uniqueness => true, :presence => true
end
