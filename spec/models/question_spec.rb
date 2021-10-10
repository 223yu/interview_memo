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
end