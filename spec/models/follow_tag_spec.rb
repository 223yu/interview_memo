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
  end
  
  describe 'バリデーションのテスト' do
    it 'ユーザモデルとの関係がN:1となっている' do
      expect(FollowTag.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it 'タグモデルとの関係がN:1となっている' do
      expect(FollowTag.reflect_on_association(:tag).macro).to eq :belongs_to
    end
  end
end