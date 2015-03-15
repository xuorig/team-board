FactoryGirl.define do
  factory :team do
    name "SomeTeam"
    description "SomeTeamDescription"
    association :owner, factory: :user
    after(:build) do |team|
      create_list(:managerships, 1, team: team, user: team.owner)
      create_list(:memberships, 1, team: team, user: team.owner)
    end
  end
end
