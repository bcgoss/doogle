class User < ApplicationRecord
  has_secure_password
  enum role: [ :registered, :admin]
  validates :email, uniqueness: true, presence: true
end
