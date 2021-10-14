# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザモデルに関するテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    let!(:other_user) { create(:user) }

    describe 'テストデータが正しく保存されることのテスト' do
      it 'userが正しく保存される' do
        expect(user.valid?).to eq true
      end
    end

    describe '空白登録できないことのテスト' do
      it 'nameカラム' do
        user.name = ''
        expect(user.valid?).to eq false
      end
      it 'emailカラム' do
        user.email = ''
        expect(user.valid?).to eq false
      end
      it 'passwordカラム' do
        user.password = ''
        expect(user.valid?).to eq false
      end
    end

    describe '一意性のテスト' do
      it 'emailカラム' do
        user.email = other_user.email
        expect(user.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    it '回答モデルとの関係が1:Nとなっている' do
      expect(User.reflect_on_association(:answers).macro).to eq :has_many
    end
    it 'フォロータグモデルとの関係が1:Nとなっている' do
      expect(User.reflect_on_association(:follow_tags).macro).to eq :has_many
    end
  end

  describe 'メソッドのテスト' do
    before do
      # テストデータの用意
      @user = create(:user)
      tags = []
      tags.push(create(:tag))
      tags.push(create(:tag, name: '新卒', genre: '状態'))
      create(:tag, name: '転職', genre: '状態')
      tags.push(create(:tag, name: '営業', genre: '職種'))
      create(:tag, name: '事務', genre: '職種')
      tags.each do |tag|
        create(:follow_tag, user: @user, tag: tag)
      end
    end
    describe 'return_follow_status_tags' do
      it '意図したハッシュが返る' do
        result = {
          '状態'=>{
            2=>{name: '新卒', status: true},
            3=>{name: '転職', status: false}
          },
          '職種'=>{
            4=>{name: '営業', status: true},
            5=>{name: '事務', status: false}
          }
        }

        expect(@user.return_follow_status_tags).to eq result
      end
    end

    describe 'return_follow_tags_array' do
      it '意図した配列が返る' do
        result = [['一般', 1], ['新卒', 2], ['営業', 4]]
        expect(@user.return_follow_tags_array).to eq result
      end
    end
  end
end