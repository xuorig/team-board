class User < ActiveRecord::Base
  # Teams
  has_many :memberships, :dependent => :destroy
  has_many :teams, :through => :memberships
  has_many :managership, :foreign_key => :manager_id, :dependent => :destroy
  has_many :managed_teams, :through => :managership, :source => :team
  has_many :owned, :class_name => "Team", :foreign_key => "owner_id"

  # Projects
  has_many :user_projects, :dependent => :destroy
  has_many :projects, :through => :user_projects
  has_many :manager_projects, :foreign_key => :manager_id, :dependent => :destroy
  has_many :managed_projects, :through => :manager_projects, :source => :project
  has_many :owned_projects, :class_name => "Project", :foreign_key => "owner_id"

  # Boards
  has_many :owned_boards, :class_name => "Board"
  has_many :board_items

  def combined_projects
    self.projects + self.managed_projects + self.owned_projects
  end

  def all_projects
    Project.where(id: combined_projects(&:id))
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.active   = true
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