class Invitation < ActiveRecord::Base
  before_create :generate_token
  #Invitations
  has_many :invitation_teams
  has_many :teams, :through => :invitation_teams

  def generate_token
   self.token = Digest::SHA1.hexdigest([self.email, Time.now, rand].join)
  end

  def url
    if Rails.env == "development" or Rails.env == "test"
      return "http://localhost:3000/users/sign_up?token=#{self.token}"
    end
    if Rails.env == "production"
      return "http://teamboardapp.com/users/sign_up?token=#{self.token}"
    end
  end
end
