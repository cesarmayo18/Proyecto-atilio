class Order < ApplicationRecord
  belongs_to :product
  belongs_to :repartidor, class_name: "Profile"
  belongs_to :cliente, class_name: "Profile"
  enum status: { creada: 0, camino: 1, entregada: 2 }
end
