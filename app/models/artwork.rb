# Public - Represents an artwork, may belong to an artist or not
class Artwork < ActiveRecord::Base
  belongs_to :artist
  validates :museum_id, :uniqueness => true, :presence => true
  validates :title, :presence => true
end
