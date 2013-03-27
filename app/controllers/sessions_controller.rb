class SessionsController < ApplicationController
	def new
	end

  def create
		auth_facebook = request.env["omniauth.auth"]
		auth_foursquare = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth_facebook["provider"], auth_facebook["uid"]) || User.create_with_omniauth(auth_facebook)
		#Event.add_events(auth_facebook)a

		#<<<< figure out how to refactor this >>>>>>
		# populate database with user events
		events = Array.new
    #if current_user.token
    rest = Koala::Facebook::API.new(auth_facebook['credentials']['token'])
    events = rest.fql_query("select uid,eid,rsvp_status from event_member where uid = me()")   

    events.each do |f_event|
      event_obj = rest.get_object(f_event["eid"]) 
      user.events.build do |event|
      	if !Event.find_by_eid(event_obj["id"])
       		event.description = event_obj["description"]
       		event.eid = event_obj["id"]
       		event.location = event_obj["location"]
       		event.name = event_obj["name"]
       		event.start_time = event_obj["start_time"]
       		event.end_time = event_obj["end_time"]
	        if event_obj["owner"]
            event.creator = event_obj["owner"]["id"]
          end
          # if venue attribute present, check for venue id
          # if venue id is present, get venue object
          # and find long, lat info
  	      event.save!
  	    end
    	end
    end

		session[:user_id] = user.id
		redirect_to user, :notice => "Signed in!"		#root_url
	end

	def add_events(auth)
    events = Array.new
    #if current_user.token
    rest = Koala::Facebook::API.new(auth['credentials']['token'])
    events = rest.fql_query("select uid,eid,rsvp_status from event_member where uid = me()")   

    events.each do |f_event|
      event_obj = rest.get_object(f_event["eid"]) 
      current_user.events.build do |event|
      	if !Event.find_by_eid(event_obj["id"])
       		event.description = event_obj["description"]
       		event.eid = event_obj["id"]
       		event.location = event_obj["location"]
       		event.name = event_obj["name"]
       		event.start_time = event_obj["start_time"]
       		event.end_time = event_obj["end_time"]
          # event.user_id = current_user.id #associate event with user
	        if event_obj["owner"]
            event.creator = event_obj["owner"]["id"]
          end
          # if venue attribute present, check for venue id
          # if venue id is present, get venue object
          # and find long, lat info
  	      #current_user.events.build(event)
  	    end
    	end
    end
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
