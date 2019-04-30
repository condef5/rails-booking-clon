class User < ApplicationRecord
  has_many :bookings
  has_many :providers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook github]

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
    user.providers << Provider.find_or_create_by(name: auth.provider, uid: auth.uid, user_id: user)
    return user
  end

  def has_role?(role)
    self.role == role
  end
end
