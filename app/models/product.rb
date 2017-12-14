class Product < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates(
    :title,
    presence: {message: "must be given"},
    uniqueness: true
  )
  validates :price, numericality: {greater_than: 0}

  validates :description, presence: true, length: {minimum: 10}

  validate :reserved

  scope :search, -> (word){
   where("title ILIKE '%#{word}%' or description ILIKE '%#{word}%'")
  }

  after_initialize :set_defaults
  before_save :capitalize

  def set_defaults
    self.price ||= "10"
  end

  def capitalize
    self.title.capitalize!
  end


  def reserved
      if title.present? &&
      title.present? && title.downcase.include?('apple')||
      title.present? && title.downcase.include?('microsoft') ||
      title.present? && title.downcase.include?('sony')
      errors.add(:title, "The name is reserved!")
      end
  end



  # if title.include?('Apple' or 'Microsoft' or 'Sony')
  #   errors.add(:title, "The name is reserved!")

end


# def self.search(key)
#  where("title ILIKE '%#{word}%' or description ILIKE '%#{word}%'")
# end
