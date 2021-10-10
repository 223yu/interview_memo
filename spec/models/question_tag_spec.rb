# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '質問タグモデルに関するテスト', type: :model do
  describe 'バリデーションのテスト' do
    let!(:question) { create(:question) }
    let!(:tag) { create(:tag) }
    let(:question_tag) { build(:question_tag, question: question, tag: tag) }

    describe 'テストデータが正しく保存されることのテスト' do
      it 'question_tagが正しく保存される' do
        expect(question_tag.valid?).to eq true
      end
    end

    describe '空白登録できないことのテスト' do
      it 'question_idカラム' do
        question_tag.question_id = ''
        expect(question_tag.valid?).to eq false
      end
      it 'tag_idカラム' do
        question_tag.tag_id = ''
        expect(question_tag.valid?).to eq false
      end
    end
  end

  describe 'バリデーションのテスト' do
    it 'タグモデルとの関係がN:1となっている' do
      expect(QuestionTag.reflect_on_association(:tag).macro).to eq :belongs_to
    end
    it '質問モデルとの関係がN:1となっている' do
      expect(QuestionTag.reflect_on_association(:question).macro).to eq :belongs_to
    end
  end
end