class Team < ActiveRecord::Base
	has_and_belongs_to_many :users, :join_table => 'teams_users', :class_name => 'User'
	has_and_belongs_to_many :admins, :join_table => 'admins_teams', :class_name => 'User'
	belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
	has_many :projects
end
