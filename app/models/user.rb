class User < ActiveRecord::Base
  has_and_belongs_to_many :teams,  :join_table => 'teams_users', :class_name => 'Team' 
  has_and_belongs_to_many :administrated_teams, :join_table => 'admins_teams', :class_name => 'Team' 
  has_many :owned, :class_name => "Team", :foreign_key => "owner_id"

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.save
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end