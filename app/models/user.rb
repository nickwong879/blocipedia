class User < ActiveRecord::Base

# attr_accessible :email, :password, :password_confirmation

before_create :confirmation_token

attr_accessor :password
before_save :encrypt_password

validates_confirmation_of :password
validates_presence_of :password, :on => :create
validates_presence_of :email
validates_presence_of :username
validates_uniqueness_of :email

def self.authenticate(username, password)
	user = find_by_username(username)
	if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
		user
	else
		nil
	end
end

def encrypt_password
	if password.present?
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
	end
end

def email_activate
	self.email_confirmed = true
	self.confirm_token = nil
	save!(:validate => false)
end

private

def confirmation_token
	if self.confirm_token.blank?
		self.confirm_token = SecureRandom.urlsafe_base64.to_s
	end
end

end
