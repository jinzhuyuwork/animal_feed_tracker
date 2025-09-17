class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         # jwt_revocation_strategy: JwtDenylist
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
end
