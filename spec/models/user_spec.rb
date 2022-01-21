# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, "会員モデルに関するテスト", type: :model do
  describe 'プロフィールを編集' do
    context "編集の空白のバリデーションチェク" do
      it "名前が空白の場合にエラーメッセージが返ってきているか" do
        @user = User.create(name: '', introduction: 'hoge')
        expect(@user).to be_invalid
        expect(@user.errors[:name]).to include("を入力してください")
      end
    end
  end
end
