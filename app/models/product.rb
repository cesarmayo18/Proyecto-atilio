class Product < ApplicationRecord
    belongs_to :profile
    enum category: { comida: 0, alcohol: 1, medicina: 2 }
end
