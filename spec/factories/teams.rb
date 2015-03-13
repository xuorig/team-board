FactoryGirl.define do
  factory :team do
    name "SomeTeam"
    description "SomeTeamDescription"
    association :owner, factory: :user
  end

end
