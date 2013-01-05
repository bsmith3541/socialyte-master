class SessionsController < ApplicationController

	def new
	end

  def create
		auth_facebook = request.env["omniauth.auth"]
		auth_foursquare = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth_facebook["provider"], auth_facebook["uid"]) || User.create_with_omniauth(auth_facebook)
		Event.add_events(auth_facebook) # populate database with user's events
		session[:user_id] = user.id
		redirect_to root_url, :notice => "Signed in!"		
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end

#	def destroy
#		sign_out
#		redirect_to root_url
#	end
end
