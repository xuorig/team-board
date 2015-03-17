class Managership < ActiveRecord::Base
  validates :user, presence: true
  validates :team, presence: true

  belongs_to :team
  belongs_to :user, :foreign_key => :manager_id
end
