json.array! @products do |product|
 json.id product.id
 json.title product.title.titleize
 json.description product.description
 json.price product.price
 json.sale_price product.sale_price

 json.tags product.tags do |tag|
    json.name tag.name
  end

json.like_count product.likes.count

 json.created_at product.created_at.to_formatted_s(:db)
 json.updated_at product.updated_at.to_formatted_s(:db)

 json.author do
   json.first_name product.user&.first_name
   json.last_name product.user&.last_name
   json.full_name product.user&.full_name
 end

 json.reviews product.reviews do |review|
    json.id review.id
    json.body review.body
    json.rating review.rating
  end
end
