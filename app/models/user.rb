class User < ApplicationRecord
  has_one :profile, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  
  # after_create do
  
  # if self.profile.nil?
  #
  # profile = Profile.create(user_id: self.id)
  # end
  
  # end
  end 