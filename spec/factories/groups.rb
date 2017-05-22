FactoryGirl.define do

  factory :group do
    id          1
    name        Faker::Team.name
  end

end
