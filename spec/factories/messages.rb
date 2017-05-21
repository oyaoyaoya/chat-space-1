FactoryGirl.define do

  factory :message do
    text          "こんにちは"
    image         ""
    created_at    { Faker::Time.between(3.days.ago, Time.now, :all) }
    group_id      1
    user_id       1
  end

end
