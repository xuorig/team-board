class Project < ActiveRecord::Base
	belongs_to :team
	has_and_belongs_to_many :users, :join_table => 'users_projects', :class_name => 'User'
	has_and_belongs_to_many :admins, :join_table => 'admins_projects', :class_name => 'User'
	belongs_to :owner, :class_name => "User", :foreign_key => "project_owner_id"
	has_many :boards
end
