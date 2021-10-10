# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '回答モデルに関するテスト', type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { create(:user) }
    let!(:question) { create(:question) }
    let(:answer) { build(:answer, user: user, question: question) }

    describe 'テストデータが正しく保存されることのテスト' do
      it 'answerが正しく保存される' do
        expect(answer.valid?).to eq true
      end
    end

    describe '空白登録できないことのテスト' do
      it 'user_idカラム' do
        answer.user_id = ''
        expect(answer.valid?).to eq false
      end
      it 'question_idカラム' do
        answer.question_id = ''
        expect(answer.valid?).to eq false
      end
      it 'bodyカラム' do
        answer.body = ''
        expect(answer.valid?).to eq false
      end
    end
  end
  
  describe 'バリデーションのテスト' do
    it '質問モデルとの関係がN:1となっている' do
      expect(Answer.reflect_on_association(:question).macro).to eq :belongs_to
    end
    it 'ユーザモデルとの関係が1:Nとなっている' do
      expect(Answer.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end
end