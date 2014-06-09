class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable


  attr_accessible :email, :password, :password_confirmation,:provider, :invitation_token,:recipient_email,:first_name,:last_name,:sex,:zip,:location,:birthday,:secondary_email,:organization,:industry,:orgsize

  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  before_create :set_invitation_limit

 # class << self
 #    def serialize_from_session(key, salt)
 #      record = to_adapter.get(key.first["$oid"]) if key.present? # to_adapter.get(key.to_s)
 #      record if record && record.authenticatable_salt == salt
 #    end
 #  end

  def self.find_for_facebook_oauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
   end
  end


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info #access_token contain all the information about user provider.
    user = User.where(:email => data["email"],:provider => "Google").first
    unless user
      user = User.create(name: data["name"],# if user in not present then create user email,name and provider.
                         email: data["email"],
                         provider: "Google",
                         password: Devise.friendly_token[0,20]
      )
    end
    user
  end


def invitation_token
  invitation.token if invitation
end

def invitation_token=(token)
  self.invitation = Invitation.find_by_token(token)
end

def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
        @user = User.create! row.to_hash        
    end
  end

#   def self.new_guest
#     new { |u| u.guest = true }
#   end



# def email
#   guest ? "Guest" : email
# end
















private

def set_invitation_limit
  self.invitation_limit = 5
end



end
