class ManagerProject < ActiveRecord::Base
  validates :project, presence: true
  validates :user, presence: true

  belongs_to :project
  belongs_to :user, :foreign_key => :manager_id
end
