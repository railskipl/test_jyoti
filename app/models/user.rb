class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable


  attr_accessible :email, :password, :password_confirmation,:provider, :invitation_token,:recipient_email,:first_name,:last_name,:sex,:zip,:location,:birthday,:secondary_email,:organization,:industry,:orgsize,:toggled_status

  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation
  has_many :paste_users

  has_many :ratings
  has_many :tips
  has_many :influences
  has_many :relationships
  has_many :emails

  before_create :set_invitation_limit

  # before_create :check_user_date

  # def check_user_date
  #   c = AdviceContact.where("email like ? ",self.email).first
  #   current_date = Date.today
  #   if c
  #     created_date = c.created_at.to_date
  #     if (current_date - created_date) <= 7
  #     end
  #   end
  # end

 
  # def self.find_for_facebook_oauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     # user.name = auth.info.name   # assuming the user model has a name
  #     # user.image = auth.info.image # assuming the user model has an image
  #  end
  # end

def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
      data = access_token.extra.raw_info
      user = User.where(:email => data["email"],:provider => "Facebook").first
        #User.skip_confirmation!
      unless user
       user= User.create(name: data["name"],# if user in not present then create user email,name and provider.
                         email: data["email"],
                         provider: "Facebook",
                         password: Devise.friendly_token[0,20]
       )
      user.skip_confirmation!
      user.save
    end
    user
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
      user.skip_confirmation!
      user.save
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
    
    def self.import(file,current_user)
      CSV.foreach(file.path, headers: true) do |row|
        if !row["email"].nil?
          @user = Contact.where(:email => row["email"], :user_id => current_user.id).first_or_create
        end
      end
    end


private

def set_invitation_limit
  self.invitation_limit = 5
end



end
