class Managership < ActiveRecord::Base
  belongs_to :team
  belongs_to :manager, :class_name => "User", :inverse_of => :managed_teams, :primary_key => :manager_id
end
