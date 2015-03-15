FactoryGirl.define do
  factory :manager_projects, class: ManagerProject do
    project
    user
  end

end
