class Team < ActiveRecord::Base
  validates :name, presence: true
  validates :owner, presence: true

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :managership, :dependent => :destroy
  has_many :managers, :through => :managership, :source => :user
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :projects, :dependent => :destroy
  has_many :invitation_teams
  has_many :invitations, :through => :invitation_teams

  def pending_invites
    self.invitations.where({:accepted => false}).all
  end

  def all_users
    (self.users + self.managers) << self.owner
  end

  def as_json(options = { })
      h = super(options)
      h[:isOwner] = options[:current_user] == self.owner
      h
  end
end
