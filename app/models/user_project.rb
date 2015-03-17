class UserProject < ActiveRecord::Base
  validates :user, presence: true
  validates :project, presence: true

  belongs_to :user
  belongs_to :project
end
