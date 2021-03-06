class Event < ActiveRecord::Base
  attr_accessible :creator, :description, :eid, :end_time, :location, :name, :start_time, :user_id
  belongs_to :user

#  validates :creator, presence: true
  validates :name, presence: true
  validates :start_time, presence: true
  #validates :eid, presence: true # only facebook events have eid's
  #validates :user_id, presence: true

  # method to request a user's events and to add them to the database
  def self.add_events(auth)
    events = Array.new
    #if current_user.token
      rest = Koala::Facebook::API.new(auth['credentials']['token'])
      events = rest.fql_query("select uid,eid,rsvp_status from event_member where uid = me()")   

      events.each do |f_event|
      	event_obj = rest.get_object(f_event["eid"]) 
      	create do |event|
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
  	      	event.save!
  	      end
    		end
      end
  end
end
