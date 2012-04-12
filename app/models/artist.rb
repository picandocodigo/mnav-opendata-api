# Public - Represent the author of an artwork
class Artist < ActiveRecord::Base
  validates :name, :presence => true
  validates :museum_id, :uniqueness => true, :presence => true
  has_many :artworks
end
