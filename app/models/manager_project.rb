class ManagerProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user, :foreign_key => :manager_id
end
