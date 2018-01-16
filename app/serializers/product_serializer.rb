class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :sale_price, :created_date, :updated_date, :like_count, :tag_name
#  when you turn yur product to JSON this is how it looks  - it will have these attributes 

  def created_date
      object.created_at.to_formatted_s(:db)
  end

  def updated_date
      object.created_at.to_formatted_s(:db)
  end

  def like_count
    object.likes.count
  end

  def tag_name
    object.tags.map(&:name).join(', ')
  end

  belongs_to :user, key: :author
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :email, :full_name
  end

  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :body, :rating, :loves_count, :created_at, :updated_at, :author_full_name
    def author_full_name
      object.user&.full_name
    end

    def loves_count
      object.loves.count
      #  count is a bit faster - difference in database level
      # object.loves.length
    end
  end

  # has_many :tags
  # class TagSerializer < ActiveModel::Serializer
  #   attributes :id, :name, :created_at, :updated_at
  # end

end
