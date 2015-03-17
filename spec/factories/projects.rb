FactoryGirl.define do
  factory :project do
    name "MyProject"
    description "Project description"
    association :owner, factory: :user
    after(:create) do |project|
      create_list(:user_projects, 1, project: project, user: project.owner)
      create_list(:manager_projects, 1, project: project, user: project.owner)
    end
  end

end
