FactoryGirl.define do
  factory :user do
    id           1
    name         Faker::Name.name
    email        Faker::Internet.email
    password     Faker::Internet.password(8)

    # ユーザーが作成されると同時に実行
    after(:create) do |user|
      # ユーザーが所属するグループを５件作成
      # ユーザーがそのグループ内で投稿したメッセージを５件作成
      5.times do
        group = create(:group)
        create(:member , user: user, group: group)
        create_list(:message, 5, user: user, group: group)
      end
    end

  end
end
