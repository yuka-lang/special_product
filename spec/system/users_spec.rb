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
        context '会員一覧が表示されているか'
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