# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, "モデルに関するテスト", type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
	      expect(FactoryBot.build(:post)).to be_valid
	    end
  end
	  context "新規投稿の空白のバリデーションチェック" do
	    it "タイトルが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      @post = Post.new(title:'', introduction:'hoge', word:'hoge', image_id:'hoge', season:'hoge', evalution:'hoge')
	      expect(@post).to be_invalid
	      expect(@post.errors[:title]).to include("can't be blank")
	    end
	    it "紹介文が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      @post = Post.new(title:'hoge', introduction:'', word:'hoge', image_id:'hoge', season:'hoge', evalution:'hoge')
	      expect(@post).to be_invalid
	      expect(@post.errors[:introduction]).to include("can't be blank")
	    end
	    it "一言文が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      @post = Post.new(title:'hoge', introduction:'hoge', word:'', image_id:'hoge', season:'hoge', evalution:'hoge')
	      expect(@post).to be_invalid
	      expect(@post.errors[:word]).to include("can't be blank")
	    end
      it "投稿画像が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        @post = Post.new(title:'hoge', introduction:'hoge', word:'hoge', image_id:'', season:'hoge', evalution:'hoge')
        expect(@post).to be_invalid
        expect(@post.errors[:image_id]).to include("can't be blank")
	    end
	    it "季節が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      @post = Post.new(title:'hoge', introduction:'hoge', word:'hoge', image_id:'hoge', season:'', evalution:'hoge')
	      expect(@post).to be_invalid
	      expect(@post.errors[:season]).to include("can't be blank")
	    end
      it "都道府県が空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
        @post = Post.new(title:'hoge', introduction:'hoge', word:'hoge', image_id:'hoge', season:'hoge', evalution:'')
        expect(@post).to be_invalid
        expect(@post.errors[:evalution]).to include("can't be blank")
      end
	  end
	end