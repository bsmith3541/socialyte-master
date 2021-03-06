class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :avatar
  #has_secure_password
  has_many :events, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name: "Relationship",
                                   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  #before_save { |user| user.email = email.downcase }
  #before_save :create_remember_token

  #validates :name, presence: true, length: { maximum: 50 }
  #ALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence:   true,
  #                  format:     { with: VALID_EMAIL_REGEX },
  #                  uniqueness: { case_sensitive: false }
  #validates :password, presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true			

# omniauth stuff

  def self.create_with_omniauth(auth)  
    create! do |user|  
      user.provider = auth["provider"]  
      user.uid = auth["uid"]  
      user.name = auth["info"]["name"]  
      user.token = auth['credentials']['token']
      user.password_digest = auth["info"]["image"] # fix password digest
      user.email = auth["info"]["image"]
      user.avatar = auth["info"]["image"]
    end  
  end

# method to request a user's events and to add them to the database
  def self.add_events(auth)
    events = Array.new
    #if current_user.token
      rest = Koala::Facebook::API.new(auth['credentials']['token'])
      events = rest.fql_query("select uid,eid,rsvp_status from event_member where uid = me()")   

      events.each do |f_event|
        event = Event.new
        event_obj = rest.get_object(f_event["eid"]) 
        event.description = event_obj["description"]
        event.eid = event_obj["eid"]
        event.location = event_obj["location"]
        event.name = event_obj["name"]
        event.start_time = event_obj["start_time"]
        event.creator = event_obj["owner"]["id"]
        event.save
      end
  end

# you can remove this if stuff really fucks up
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

# I need this private stuff
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
  