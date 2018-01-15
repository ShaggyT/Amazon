class Product < ApplicationRecord
  # validation will be run before save
  has_many :reviews, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :likers, through: :likes, source: :user

  has_many :favourites, dependent: :destroy

  has_many :favouriters, through: :favourites, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # belongs_to :user, optional: true
  belongs_to :user

  validates(
    :title,
    presence: {message: "must be given"},
    uniqueness: true,
    # case_sensitive: false
  )
  validates :price, numericality: {greater_than: 0}

  validates :description, presence: true, length: {minimum: 10}

  validate :reserved

  scope :search, -> (word){
   where("title ILIKE '%#{word}%' or description ILIKE '%#{word}%'")
  }


  # def self.search(key)
  #  where("title ILIKE '%#{word}%' or description ILIKE '%#{word}%'")
  # end

  # database method (writing a query with scope)

  # scope :price_gt_0, -> (){
  #   where("price > 0")
  # }


  validate :sale_price_must_be_less_than_or_equal_to_price

  def sale_price_must_be_less_than_or_equal_to_price
    if price.present? && sale_price.present? && sale_price > price
      errors.add(:sale_price, "can't be greater than price")
    end
  end

  # a method called on_sale? that returns true or false whether the product is on sale or not


  def on_sale?
    if price.present? && sale_price.present? && sale_price < price
       true
    end
  end


  def votes_result
    votes.where({ is_up: true }).count - votes.where({ is_up: false }).count
  end

  after_initialize :set_defaults
  before_validation :capitalize

  private
  def set_defaults
    self.price ||= 10
    self.sale_price ||= self.price
  end

  def capitalize
    self.title.try(:capitalize!)
  end

  def reserved
    if
      title.present? && title.downcase.include?('apple')||
      title.present? && title.downcase.include?('microsoft') ||
      title.present? && title.downcase.include?('sony')
      errors.add(:title, "The name is reserved!")
    end
  end

end
