FactoryGirl.define do
  factory :user_projects, class: UserProject do
    project
    user
  end

end
