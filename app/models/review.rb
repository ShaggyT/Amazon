class Review < ApplicationRecord
  belongs_to :product
  # validates :rating,presence: true, :inclusion => 1..5
  belongs_to :user

  validates :rating, presence:true, numericality: {
  greater_than_or_equal_to:1,
  less_than_or_equal_to:5,
  message: 'The rating must be between 1 to 5'
  }

end
