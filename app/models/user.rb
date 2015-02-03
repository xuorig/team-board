class User < ActiveRecord::Base
  # Teams
  has_many :memberships
  has_many :teams, :through => :memberships
  has_many :managership, :foreign_key => :manager_id
  has_many :managed_teams, :through => :managership, :source => :team
  has_many :owned, :class_name => "Team", :foreign_key => "owner_id"

  # Projects
  #has_and_belongs_to_many :projects,  :join_table => 'users_projects', :class_name => 'Project' 
  #has_and_belongs_to_many :administrated_teams, :join_table => 'admins_projects', :class_name => 'Project' 
  #has_many :project_owned, :class_name => "Project", :foreign_key => "project_owner_id"

  # Boards
  has_many :boards

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.save
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end