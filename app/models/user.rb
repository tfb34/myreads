class User < ApplicationRecord
	attr_accessor :remember_token
	before_save {email.downcase!}
	validates :username, presence: true, 
						 length: {maximum: 20},
						 uniqueness: {case_sensitive:false}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence:true, 
					  length: {maximum: 255}, 
					  format: {with: VALID_EMAIL_REGEX},
					  uniqueness:{case_sensitive: false}

    #uses bcrypt
	has_secure_password
	validates :password, presence: true, length: {minimum: 8}

	# CarrierWave
	mount_uploader :avatar, AvatarUploader
	# Returns encryption of given string
	def User.digest(string)
		cost  = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													   BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a random token.
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Creates a new token and updates remember_digest.
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Returns true if the given token matches the digest
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end

	# Forgets a user
	def forget
		update_attribute(:remember_digest, nil)
	end

end
