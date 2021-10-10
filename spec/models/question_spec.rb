# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '質問モデルに関するテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:question) { build(:question) }

    describe 'テストデータが正しく保存されることのテスト' do
      it 'questionが正しく保存される' do
        expect(question.valid?).to eq true
      end
    end

    describe '空白登録できないことのテスト' do
      it 'bodyカラム' do
        question.body = ''
        expect(question.valid?).to eq false
      end
      it 'answer_countカラム' do
        question.answer_count = ''
        expect(question.valid?).to eq false
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    it '回答モデルとの関係が1:Nとなっている' do
      expect(Question.reflect_on_association(:answers).macro).to eq :has_many
    end
    it '質問タグモデルとの関係が1:Nとなっている' do
      expect(Question.reflect_on_association(:question_tags).macro).to eq :has_many
    end
  end
end