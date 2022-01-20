FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Lorem.characters(number: 5) }
    # タイトルのダミーデータ。名前を１０字作成する
    introduction { Faker::Lorem.characters(number:30) }
    # 紹介文のダミーデータ。ランダムな英数文字列を30字作成する
    word { Faker::Lorem.characters(number:10) }
    #一言文のダミーデータ
    image_id { Faker::Lorem.characters(number:10) }
    #投稿画像のダミーデータ
    season { Faker::Lorem.characters(number:2) }
    #季節のダミーデータ
    prefectures { Faker::Lorem.characters(number:5) }
    #都道府県のダミーデータ
  end
end