class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :events, dependent: :destroy

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
      user.password_digest = auth["info"]["location"] # fix password digest
      user.email = auth["info"]["image"]
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

# I need this private stuff
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

  #def self.create_with_omniauth(auth)
  #create! do |user|
  #  user.provider = auth["provider"]
  #  user.uid = auth["uid"]
  #  user.name = auth["info"]["name"]
 # 	end
 # end
end
