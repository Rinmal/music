class Tag < ApplicationRecord
  has_many :taggings
  has_many :posts, through: :taggings
  
  validates :body, presence: true, length: {maximum: 50 }
end
