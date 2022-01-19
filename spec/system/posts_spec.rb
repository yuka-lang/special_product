require 'rails_helper'

describe '投稿のテスト' do
  let!(:list) { create(:list, title:'hoge',body:'body') }
  # describe 'トップ画面(top_path)のテスト' do
  #   before do
  #     visit top_path
  #   end
  #   context '表示の確認' do
  #     it 'トップ画面(top_path)に「ここはTopページです」が表示されているか' do
  #       expect(page).to have_content 'ここはTopページです'
  #     end
  #     it 'top_pathが"/top"であるか' do
  #       expect(current_path).to eq('/top')
  #     end
  #   end
  # end

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
  end
  #   context '投稿処理のテスト' do
  #     it '投稿後のリダイレクト先は正しいか' do
  #       fill_in 'list[title]', with: Faker::Lorem.characters(number:5)
  #       fill_in 'list[body]', with: Faker::Lorem.characters(number:20)
  #       click_button '投稿'
  #       expect(page).to have_current_path todolist_path(List.last)
  #     end
  #   end
  # end

  describe "投稿一覧のテスト" do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content post.title
        expect(page).to have_link post.title
      end
    end
  end

  describe "詳細画面のテスト" do
    before do
      visit post_path(post)
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
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
    context 'post削除のテスト' do
      it 'postの削除' do
        expect{ post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it '編集前のタイトルと紹介文がフォームに表示(セット)されている' do
        expect(page).to have_field 'list[title]', with: list.title
        expect(page).to have_field 'list[introduction]', with: list.introduction
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    # context '更新処理に関するテスト' do
    #   it '更新後のリダイレクト先は正しいか' do
    #     fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
    #     fill_in 'list[body]', with: Faker::Lorem.characters(number:20)
    #     click_button '保存'
    #     expect(page).to have_current_path todolist_path(list)
    #   end
    # end
  end
end