class Artist < ActiveRecord::Base
  validates :name, :presence => true
  validates :museum_id, :uniqueness => true
  has_many :artworks
end
