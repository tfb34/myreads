class User < ApplicationRecord
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

end
