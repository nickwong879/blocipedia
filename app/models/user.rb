class User < ActiveRecord::Base

# attr_accessible :email, :password, :password_confirmation

attr_accessor :password

has_secure_password


end
