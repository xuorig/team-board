FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "UserName"
    email "user@test.com"
    oauth_token "MyString"
    oauth_expires_at "2015-01-11 16:09:03"

    # Teams
    factory :team_member do
      email "team_member@test.com"
      after(:create) do |user|
        team = create(:team)
        create_list(:memberships, 1, team: team, user: user)
      end
    end

    factory :team_manager do
      email "team_manager@test.com"
      after(:create) do |user|
        team = create(:team)
        create_list(:memberships, 1, team: team, user: user)
        create_list(:managerships, 1, team: team, user: user)
      end
    end

    factory :team_owner do
      email "team_owner@test.com"
      after(:create) do |user|
        # team factory creates memberships for its owner
        create(:team, owner: user)
      end
    end

    #Projects
    factory :project_member do
      email "project_member@test.com"
      after(:create) do |user|
        project = create(:project)
        create_list(:user_projects, 1, project: project, user: user)
      end
    end

    factory :project_owner do
      email "project_owner@test.com"
      after(:create) do |user|
        create(:project, owner: user)
      end
    end

    #Boards
    factory :board_owner do
      email "board_owner@test.com"
      after(:create) do |user|
        create(:board, owner: user)
      end
    end

  end
end
