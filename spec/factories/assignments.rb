FactoryGirl.define do
  factory :assignment do
    board_item
    association :user,  :factory => :user, :email => 'assignementuser@email.com'
  end
end
