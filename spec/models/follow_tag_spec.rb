# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'フォロータグモデルに関するテスト', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { create(:user) }
    let!(:tag) { create(:tag) }
    let(:follow_tag) { build(:follow_tag, user: user, tag: tag) }

    describe 'テストデータが正しく保存されることのテスト' do
      it 'follow_tagが正しく保存される' do
        expect(follow_tag.valid?).to eq true
      end
    end

    describe '空白登録できないことのテスト' do
      it 'user_idカラム' do
        follow_tag.user_id = ''
        expect(follow_tag.valid?).to eq false
      end
      it 'tag_idカラム' do
        follow_tag.tag_id = ''
        expect(follow_tag.valid?).to eq false
      end
    end

    describe '一意性のテスト' do
      it 'user_id, tag_idの組み合わせは一意であることのテスト' do
        create(:follow_tag, user: user, tag: tag)
        expect(follow_tag.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    it 'ユーザモデルとの関係がN:1となっている' do
      expect(FollowTag.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it 'タグモデルとの関係がN:1となっている' do
      expect(FollowTag.reflect_on_association(:tag).macro).to eq :belongs_to
    end
  end

  describe 'メソッドのテスト' do
    describe 'self.return_follow_tags_index(array)' do
      before do
        @user = create(:user)
        tag_1 = create(:tag)
        tag_2 = create(:tag, name: '新卒', genre: '状態')
        tag_3 = create(:tag, name: '転職', genre: '状態')
        create(:tag, name: '営業', genre: '職種')
        create(:follow_tag, user: @user, tag: tag_1)
        create(:follow_tag, user: @user, tag: tag_2)
        create(:follow_tag, user: @user, tag: tag_3)
      end

      it '意図したデータが返る' do
        array = [1,2]
        result = []
        result.push(FollowTag.find(1)).push(FollowTag.find(2))
        expect(FollowTag.return_follow_tags_index(array)).to eq result
      end
    end
  end
end