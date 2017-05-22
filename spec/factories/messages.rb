FactoryGirl.define do

  factory :message do
    text          Faker::Lorem.sentence
    image         ""
    created_at    { Faker::Time.between(10.days.ago, 5.days.ago, :all) }
    updated_at    { Faker::Time.between(4.days.ago, Time.now, :all) }
    group_id      1
    user_id       1
  end

end
