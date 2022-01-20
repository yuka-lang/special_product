# frozen_string_literal: true

require 'rails_helper'

describe '会員のテスト' do
  before do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

    describe "会員画面のテスト" do
      before do
        visit users_path
      end
        context '表示の確認' do
          it 'users_pathが"/users"であるか' do
            expect(current_path).to eq('/users')
          end
        end
        context '会員一覧が表示されているか' do
          it 'プロフィール画像が表示されているか' do
            expect(page).to have_link @user.profile_image
          end
          it '会員名前が表示されているか' do
            expect(page).to have_content @user.name
          end
          it '会員の紹介文が表示されているか' do
            expect(page).to have_content @user.introduction
          end
        end
    end

    describe '会員編集画面のテスト' do
      before do
        visit edit_user_path(@user)
      end
        context '表示の確認' do
          it '編集前の名前と紹介文が表示されている' do
            expect(page).to have_field 'user[name]', with: @user.name
            expect(page).to have_field 'user[introduction]', with: @user.introduction
          end
          it '変更を保存ボタンが表示される' do
            expect(page).to have_button '変更を保存'
          end
        end
        context '更新処理に関するテスト' do
          it '更新後のリダイレクト先は正しいか' do
            fill_in 'user[name]', with: Faker::Lorem.characters(number:5)
            fill_in 'user[introduction]', with: Faker::Lorem.characters(number:20)
            attach_file 'user[profile_image]', Rails.root.join('app', 'assets', 'images', 'no_image.jpg')
            click_button '変更を保存'
            expect(page).to have_current_path user_path(User.last)
          end
        end
    end

end