# json.extract! order, :id, :date, :lotstock, :quantity, :price, :total, :orderstatus_id, :picture_id, :created_at, :updated_at
json.extract! order, :id, :ordernum,:date, :lotstock, :quantity, :price, :total, :orderstatus_id, :customer_id,:created_at, :updated_at
json.url order_url(order, format: :json)
