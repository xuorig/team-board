class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2, :facebook]

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

  def new_teams
    Invitation.where(:email => self.email).all.sum("new")
  end

  def remove_new_invites
    invite = Invitation.where(:email => self.email)
    if invite.blank?
      # Hasnt been invited
    else
      @invite = invite.first
      @invite.new = 0
      @invite.save!
    end
  end

  def accept_invite invite_token
    @invitation = Invitation.where({:token => invite_token}).first
    @invitation_teams = InvitationTeam.where({:invitation_id => @invitation.id}).all
    @invitation_teams.each do |invitation_team|
      if invitation_team.as_manager
        byebug
        invitation_team.team.managers << self
      else
        invitation_team.team.users << self
      end
    end
    @invitation.accepted = true
    @invitation.save!
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
      user.name     = auth.info.name
      user.email    = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.save!
    end
  end
end