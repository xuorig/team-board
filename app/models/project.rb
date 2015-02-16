class Project < ActiveRecord::Base
  belongs_to :team
  belongs_to :owner, :class_name => "User"
  
  has_many :user_projects, :dependent => :destroy
  has_many :users, :through => :user_projects

  has_many :manager_projects, :dependent => :destroy
  has_many :managers, :through => :manager_projects, :source => :user

  has_many :boards

  def combined_users
    (self.users + self.managers) << self.owner
  end

  def users_managers_owner
    User.where(id: combined_users(&:id))
  end
end
