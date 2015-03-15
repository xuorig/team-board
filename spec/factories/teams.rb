FactoryGirl.define do
  factory :team do
    name "MyTeam"
    description "TeamDescription"
    association :owner, factory: :user
    after(:build) do |team|
      team.managership << build_list(:managerships, 1, team: team, user: team.owner)
      team.memberships << build_list(:memberships, 1, team: team, user: team.owner)
    end

    after(:create) do |team|
      create_list(:managerships, 1, team: team, user: team.owner)
      create_list(:memberships, 1, team: team, user: team.owner)
    end
  end
end
