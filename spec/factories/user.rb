FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    # ダミーデータ。emailアドレスの形を指定
    password { Faker::Lorem.characters(number: 8) }
  end
end