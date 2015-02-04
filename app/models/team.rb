class Team < ActiveRecord::Base
	has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :managership, :dependent => :destroy
	has_many :managers, :through => :managership, :source => :user
	belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
	has_many :projects, :dependent => :destroy

  def as_json(options = { })
      h = super(options)
      h[:isOwner] = options[:current_user] == self.owner
      h
  end
end
