FactoryGirl.define do
  factory :board do
    name "MyBoard"
    description "BoardDescription"
    color ""
    association :owner, :factory => :user, :email => 'boardowneruser@email.com'
    project
  end

end
