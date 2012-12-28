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

# for koala
#		session['fb_auth'] = request.env['omniauth.auth']
#   session['fb_access_token'] = omniauth['credentials']['token']
#   session['fb_error'] = nil

		
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_url, :notice => "Signed out!"
	end

#	def create
#		user = User.find_by_email(params[:session][:email].downcase)
#		if user && user.authenticate(params[:session][:password])
#			sign_in user
#			redirect_back_or user
#		else
#			flash.now[:error] = 'Invalid email/password combination'
#			render 'new'
#		end
#	end

#	def destroy
#		sign_out
#		redirect_to root_url
#	end
end
