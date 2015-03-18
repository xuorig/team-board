class Project < ActiveRecord::Base
  validates :owner, presence: true
  
  belongs_to :team
  belongs_to :owner, :class_name => "User"
  
  has_many :user_projects, :dependent => :destroy
  has_many :users, :through => :user_projects

  has_many :boards

  def all_users
    (self.team.all_users + self.users << self.owner).uniq
  end

end
