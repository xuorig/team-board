class Managership < ActiveRecord::Base
  validates :user, presence: true
  validates :team, presence: true

  belongs_to :team
  belongs_to :user, :foreign_key => :manager_id

  after_create :verify_existing_membership

  def verify_existing_memberhip
    # if a membership already exists for that user and team, remove it and replace it by a managership
    existingMembersShip = Membership.where({team_id: self.team_id, user_id: self.manager_id})
    if !existingMembersShip.blank?
      existingMembersShip.first.delete()
    end
  end
end
