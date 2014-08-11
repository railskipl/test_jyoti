class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable




  attr_accessible :email, :password, :password_confirmation,:provider,:uid, :invitation_token,:recipient_email,:first_name,:last_name,:sex,:zip,:location,:birthday,:secondary_email,:organization,:industry,:orgsize,:toggled_status,:city

  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
  has_many :paste_users

  has_many :ratings
  has_one :rhd_store
  has_many :tips
  has_many :influences
  has_many :relationships
  has_many :sponsees
  has_many :sponsercfs
  has_many :sponsers
  has_and_belongs_to_many :roles
  has_many :user_invitations
  has_many :emails
  has_many :contacts
  has_many :advice_contacts
  
  has_many   :emails
  has_many   :plans
  has_many   :subscriptions
  belongs_to :trial_day

  has_many :suggestions
  has_many :praises
  has_many :criticisms
  has_many :generals
  has_many :responses
  has_many :reactions
  belongs_to :country

  before_create :set_invitation_limit


 

def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
      data = access_token.extra.raw_info
      user = User.where(:email => data["email"],:provider => "Facebook").first
        #User.skip_confirmation!
      unless user
       user= User.create(first_name: data["first_name"],# if user in not present then create user email,name and provider.
                         email: data["email"],
                         provider: "Facebook",
                         password: Devise.friendly_token[0,20]
       )
      user.skip_confirmation!
      user.save
    end
    user
 end





 # def self.find_for_google_oauth2(auth, signed_in_resource=nil)
 #    user = User.where(:provider => auth.provider, :uid => auth.uid).first
 #    if user
 #      return user
 #    else
 #      registered_user = User.where(:email => auth.info.email).first
 #      if registered_user
 #        return registered_user
 #      else
 #        user = User.create(name:auth.extra.raw_info.name,
 #                            provider:auth.provider,
 #                            uid:auth.uid,
 #                            email:auth.info.email,
 #                            password:Devise.friendly_token[0,20]
 #                          )
 #      end
       
 #    end
 #  end




  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info #access_token contain all the information about user provider.
    user = User.where(:email => data["email"],:provider => "Google").first
    unless user
      user = User.create(first_name: data["first_name"],# if user in not present then create user email,name and provider.
                         email: data["email"],
                         provider: "Google",
                         password: Devise.friendly_token[0,20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end



 def self.from_omniauth(auth)
  if user = User.find_by_email(auth.info.email)
    user.provider = auth.provider
    user.uid = auth.uid
    user
  else
   where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
   end
  end
end





#   def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
#     data = access_token.info
#     user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
#     if user
#       return user
#     else
#       registered_user = User.where(:email => access_token.info.email).first
#       if registered_user
#         return registered_user
#       else
#         user = User.create(name: data["name"],
#           provider:access_token.provider,
#           email: data["email"],
#           uid: access_token.uid ,
#           password: Devise.friendly_token[0,20],
#         )
#       end
#    end
# end







 def google_oauth2
user = User.from_omniauth(request.env["omniauth.auth"])
if user.persisted?
flash.notice = "Signed in Through Google!"
sign_in_and_redirect user
else
session["devise.user_attributes"] = user.attributes
flash.notice = "You are almost Done! Please provide a password to finish setting up your account"
redirect_to new_user_registration_url
end
end


  def facebook
    @facebook ||= Koala::Facebook::API.new(access_token)
    block_given? ? yield(@facebook) : @facebook
   rescue Koala::Facebook::APIError => e
    logger.info e.to_s
    nil
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
    
    def self.import(file,current_user)
      CSV.foreach(file.path, headers: true) do |row|
        if !row["email"].nil?
          @user = Contact.where(:email => row["email"], :user_id => current_user.id).first_or_create
        end
      end
    end



     #Method for trial days for admin
  def self.admin_user_plan_expiry(user)
      @trial_days = TrialDay.first
      @admin_user_plan_expiry = (user.created_at + @trial_days.days.days)
      @current_date = (Time.zone.now)
      @remaining_days = (@admin_user_plan_expiry - @current_date).to_i / 1.day
  end






private

def set_invitation_limit
  self.invitation_limit = 5
end



end
