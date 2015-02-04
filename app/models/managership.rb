class Managership < ActiveRecord::Base
  belongs_to :team
  belongs_to :user, :foreign_key => :manager_id
end
