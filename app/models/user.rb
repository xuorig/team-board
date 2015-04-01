class User < ActiveRecord::Base
  validates :email, presence: true
  validates :email, uniqueness: true

  # Teams
  has_many :memberships, :dependent => :destroy
  has_many :teams, :through => :memberships
  has_many :managership, :foreign_key => :manager_id, :dependent => :destroy
  has_many :managed_teams, :through => :managership, :source => :team
  has_many :owned, :class_name => "Team", :foreign_key => "owner_id"

  # Projects
  has_many :user_projects, :dependent => :destroy
  has_many :projects, :through => :user_projects
  has_many :owned_projects, :class_name => "Project", :foreign_key => "owner_id"

  # Boards
  has_many :owned_boards, :class_name => "Board"

  # Item Assignments
  has_many :assignments, :foreign_key => :assignee_id, :dependent => :destroy
  has_many :assigned_items, :through => :assignments, :source => :board_item

  # Combine self projects + team projects
  def combined_projects
    self.projects + self.teams.map(&:projects).flatten(1) + self.owned_projects
  end

  def all_projects
    Project.where(id: combined_projects(&:id))
  end

  def combined_teams
    self.teams + self.managed_teams + self.owned
  end

  def all_teams
    Team.where(id: combined_teams(&:id))
  end

  def boards
    Board.where(:project_id => all_projects.map(&:id))
  end

  def board_items
    BoardItem.where(:board_id => self.boards.map(&:id))
  end

  def self.from_omniauth(auth)
    existingRecord = where(email: auth.info.email)
    if existingRecord.blank? or existingRecord.first.provider == nil
      user = existingRecord.first || User.new
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
      user.active   = true
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.save!
      return user
    else
      # refresh access token after user relogin.
      # TODO refresh tokens and Tokens model that refreshes itself
      user = existingRecord.first
      user.oauth_token = auth.credentials.token
      user.save
      return user
    end
  end
end