class Profile < ApplicationRecord
  belongs_to :user
  has_many :products
  enum role: { cliente: 0, repartidor: 1, tienda: 2}

  def self.clima

      @url = RestClient.get('http://api.weatherapi.com/v1/forecast.json?q=Santiago', headers={key:'e669c0ea28644d56861182149200609'})
      @clima = JSON.parse(@url.body)
      return @clima
    end
end
