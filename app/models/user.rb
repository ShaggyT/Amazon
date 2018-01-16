class User < ApplicationRecord
  has_many :products, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product
  has_many :favourites, dependent: :destroy
  has_many :favourited_product, through: :favourites, source: :product

  has_many :loved, dependent: :destroy
  has_many :loved_reviews, through: :loves, source: :review

  has_many :votes, dependent: :destroy
  has_many :voted_products, through: :votes, source: :product

  has_many :review_votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :answer

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
  def full_name
    "#{first_name} #{last_name}"
  end

  before_create :generate_api_key

  private

  def generate_api_key
    loop do
      self.api_key = SecureRandom.hex(32)
      break unless User.exists?(api_key: api_key)
    end
  end
end
