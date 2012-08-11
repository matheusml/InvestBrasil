class User < ActiveRecord::Base
	has_many :company_users

	def self.from_omniauth(auth)
	  user = User.find_by_provider_and_uid auth["provider"], auth["uid"]
	  if user.blank?
	  	create! do |user|
		    user.provider = auth.provider
	  	  user.uid = auth.uid
	      user.name = auth.info.name
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
	
end
