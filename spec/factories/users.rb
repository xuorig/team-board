FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    email "email@test.com"
    oauth_token "MyString"
    oauth_expires_at "2015-01-11 16:09:03"

    factory :team_owner do
      after(:build) do |user|
        team = build(:team, owner: user)
        create_list(:managerships, 1, team: team, user: user)
        create_list(:memberships, 1, team: team, user: user)
      end
    end
  end

end
