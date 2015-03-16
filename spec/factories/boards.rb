FactoryGirl.define do
  factory :board do
    name "MyBoard"
    description "BoardDescription"
    color ""
    association :owner, factory: :user
    project
  end

end
