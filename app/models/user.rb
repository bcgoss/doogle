class User < ApplicationRecord
  has_secure_password
  enum role: [ :registered, :admin]
end
