class Team < ActiveRecord::Base
	has_and_belongs_to_many :users
	#belongs_to :owner, :class_name => "User", "foreign_key" => "owner_id"
end
