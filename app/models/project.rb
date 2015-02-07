class Project < ActiveRecord::Base
  belongs_to :team
  
  has_many :user_projects, :dependent => :destroy
  has_many :users, :through => :user_projects

  has_many :manager_projects, :dependent => :destroy
  has_many :managers, :through => :manager_projects, :source => :user

  has_many :boards
end
