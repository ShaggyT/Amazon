# api_client/client.rb
require 'faraday'
require 'json'

response = Faraday.get 'http://localhost:3000/api/v1/products'

p JSON.parse(response.body)
