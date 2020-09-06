json.extract! product, :id, :description, :name, :price, :rating, :type, :store_id, :products_pic, :profile, :created_at, :updated_at
json.url product_url(product, format: :json)
