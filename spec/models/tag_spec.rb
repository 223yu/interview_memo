# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'タグモデルに関するテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:tag) { build(:tag) }

    describe 'テストデータが正しく保存されることのテスト' do
      it 'tagが正しく保存される' do
        expect(tag.valid?).to eq true
      end
    end

    describe '空白登録できないことのテスト' do
      it 'nameカラム' do
        tag.name = ''
        expect(tag.valid?).to eq false
      end
      it 'genreカラム' do
        tag.genre = ''
        expect(tag.valid?).to eq false
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    it 'フォロータグモデルとの関係が1:Nとなっている' do
      expect(Tag.reflect_on_association(:follow_tags).macro).to eq :has_many
    end
    it '質問タグモデルとの関係が1:Nとなっている' do
      expect(Tag.reflect_on_association(:question_tags).macro).to eq :has_many
    end
  end
end