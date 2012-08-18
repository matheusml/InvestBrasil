class User < ActiveRecord::Base
	has_many :company_users
	has_many :subcomments
	has_many :comments

	attr_accessible :name, :email, :password
	attr_accessor :password

	before_save :encrypt_password

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	def self.from_omniauth(auth)
	  user = User.find_by_provider_and_uid auth["provider"], auth["uid"]
	  if user.blank?
	  	create! do |user|
		    user.provider = auth.provider
	  	  user.uid = auth.uid
	      user.name = auth.info.name
	      user.email = auth.info.email
	      user.oauth_token = auth.credentials.token
	      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
	  	end
	  else
	  	user.update_attributes( 
	  		:provider => auth.provider,
	  	  :uid => auth.uid, 
	  	  :name => auth.info.name,
	      :oauth_token => auth.credentials.token,
	      :oauth_expires_at => Time.at(auth.credentials.expires_at)
	    )
	    user
	  end
	end

	def is_following_company? company_id
		company_user = CompanyUser.where(:user_id => self.id, 
																		 :company_id => company_id, 
																		 :follow => true).first
		not company_user.blank?
	end
	
end
