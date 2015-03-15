FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "UserName"
    email "email@test.com"
    oauth_token "MyString"
    oauth_expires_at "2015-01-11 16:09:03"

    # Teams
    factory :team_member do
      after(:create) do |user|
        team = create(:team)
        create_list(:memberships, 1, team: team, user: user)
      end
    end

    factory :team_manager do
      after(:create) do |user|
        team = create(:team)
        create_list(:memberships, 1, team: team, user: user)
        create_list(:managerships, 1, team: team, user: user)
      end
    end

    factory :team_owner do
      after(:create) do |user|
        # team factory creates memberships for its owner
        create(:team, owner: user)
      end
    end

    #Projects
    factory :project_member do
      after(:build) do |user|
        project = build(:project)
        create_list(:user_projects, 1, project: project, user: user)
      end
    end

    factory :project_manager do
      after(:build) do |user|
        project = build(:project)
        create_list(:user_projects, 1, project: project, user: user)
        create_list(:manager_projects, 1, project: project, user: user)
      end
    end

    factory :project_owner do
      after(:build) do |user|
        build(:project, owner: user)
      end
    end

    #Boards
    factory :board_owner do
      after(:build) do |user|
        build(:board, owner: user)
      end
    end

  end
end
