# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post, user: @user)
    sign_in @user
  end

    describe "投稿画面(new_post_path)のテスト" do
      before do
        visit new_post_path
      end
        context '表示の確認' do
          it 'new_post_pathが"/posts/new"であるか' do
            expect(current_path).to eq('/posts/new')
          end
          it '登録ボタンが表示されているか' do
            expect(page).to have_button '登録'
          end
        end
        context '投稿処理のテスト' do
          it '投稿後のリダイレクト先は正しいか' do
            fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
            fill_in 'post[introduction]', with: Faker::Lorem.characters(number:30)
            fill_in 'post[word]', with: Faker::Lorem.characters(number:10)
            fill_in 'post[prefectures]', with: Faker::Lorem.characters(number:5)
            attach_file 'post[image]', Rails.root.join('app', 'assets', 'images', 'no_image.jpg')
            choose '春(3月~5月)'
            click_button '登録'
            expect(page).to have_current_path post_path(Post.last)
          end
        end
    end

    describe "投稿一覧のテスト" do
      before do
        visit posts_path
      end
        context '表示の確認' do
          it '投稿されたタイトルが表示されているか' do
            expect(page).to have_content @post.title
          end
        end
    end

    describe "詳細画面のテスト" do
      before do
        visit post_path(@post)
      end
        context '表示の確認' do
          it '削除リンクが存在しているか' do
            expect(page).to have_link '削除'
          end
          it '編集リンクが存在しているか' do
            expect(page).to have_link '編集'
          end
        end
        context 'リンクの遷移先の確認' do
          it '編集のリンク遷移先は編集画面か' do
            edit_link = page.find_link '編集' 
            edit_link.click
            expect(current_path).to eq('/posts/' + @post.id.to_s + '/edit')
          end
        end
        context 'post削除のテスト' do
          it 'postの削除' do
            expect{ @post.destroy }.to change{ Post.count }.by(-1)
          end
        end
    end

    describe '編集画面のテスト' do
      before do
        visit edit_post_path(@post)
      end
        context '表示の確認' do
          it '編集前のタイトルと紹介文がフォームに表示(セット)されている' do
            expect(page).to have_field 'post[title]', with: @post.title
            expect(page).to have_field 'post[introduction]', with: @post.introduction
          end
          it '保存ボタンが表示される' do
            expect(page).to have_button '保存'
          end
        end
        context '更新処理に関するテスト' do
          it '更新後のリダイレクト先は正しいか' do
            fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
            fill_in 'post[introduction]', with: Faker::Lorem.characters(number:30)
            fill_in 'post[word]', with: Faker::Lorem.characters(number:10)
            fill_in 'post[prefectures]', with: Faker::Lorem.characters(number:5)
            click_button '保存'
            expect(page).to have_current_path post_path(@post)
          end
        end
    end
end