class Profile < ApplicationRecord
  belongs_to :user
  has_many :products
  enum role: { cliente: 0, repartidor: 1, tienda: 2} 
end
