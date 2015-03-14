FactoryGirl.define do
  factory :team do
    name "SomeTeam"
    description "SomeTeamDescription"
    association :owner, factory: :user
    # association :managership, factory: :managership
    factory :team_with_managers do
      after(:build) do |team|
        create_list(:managership, 1, team: team, user: team.owner)
      end
    end

  end
end
