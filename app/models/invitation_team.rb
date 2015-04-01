class InvitationTeam < ActiveRecord::Base
  belongs_to :team
  belongs_to :invitation
end
