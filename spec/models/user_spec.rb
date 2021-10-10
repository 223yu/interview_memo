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
end