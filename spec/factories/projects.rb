FactoryGirl.define do
  factory :project do
    name "MyProject"
    description "Project description"
    association :owner, :factory => :user, :email => 'projectowneruser@email.com'
  end

end
