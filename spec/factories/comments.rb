FactoryGirl.define do
  factory :comment do
    user
    board_item
    content "MyText"
  end

end
