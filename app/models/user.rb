class User < ApplicationRecord
    has_secure_password
    
    validates :UserName, presence: true, uniqueness: true
    validates :password, presence: true
end
