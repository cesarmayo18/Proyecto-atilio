class Product < ApplicationRecord
    belongs_to :profile
    enum category: { comida: 0, alcohol: 1, medicina: 2 }
    has_many :orders, class_name: "Order", foreign_key: "cliente_id"
    has_many :orders, class_name: "Order", foreign_key: "repartidor_id"
end
