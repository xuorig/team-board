FactoryGirl.define do
  factory :memberships, class: Membership do
    user
    team
  end
end
