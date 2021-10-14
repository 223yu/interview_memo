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

    describe '一意性のテスト' do
      it 'user_id, question_idの組み合わせは一意であることのテスト' do
        create(:answer, user: user, question: question)
        expect(answer.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    it '質問モデルとの関係がN:1となっている' do
      expect(Answer.reflect_on_association(:question).macro).to eq :belongs_to
    end
    it 'ユーザモデルとの関係が1:Nとなっている' do
      expect(Answer.reflect_on_association(:user).macro).to eq :belongs_to
    end
  end

  describe 'メソッドのテスト' do
    before do
      @user = create(:user)
      tag = create(:tag)
      @question = create(:question, tag: tag, answer_count: 0)
      other_question = create(:question, tag: tag, answer_count: 1)
      create(:answer, user: @user, question: other_question)
    end
    describe 'save_and_increase_answer_count' do
      context 'ロールバックせずに正常に保存された場合' do
        before do
          answer = build(:answer, user: @user, question: @question)
          answer.save_and_increase_answer_count
        end
        it 'answerのレコード数が一つ増えている' do
          expect(Answer.all.length).to eq 2
        end
        it 'question.answer_countが一つ増えている' do
          expect(Question.find(1).answer_count).to eq 1
        end
      end

      context 'ロールバックした場合' do
        before do
          answer = build(:answer, user: @user, question: @question)
          answer.user_id = ''
          answer.save_and_increase_answer_count
        end
        it 'answerのレコード数が変わっていない' do
          expect(Answer.all.length).to eq 1
        end
        it 'question.answer_countが変わっていない' do
          expect(Question.find(1).answer_count).to eq 0
        end
      end
    end

    describe 'destroy_and_decrease_answer_count' do
      context 'ロールバックせずに正常に削除された場合' do
        before do
          Answer.find(1).destroy_and_decrease_answer_count
        end
        it 'answerのレコード数が一つ減っている' do
          expect(Answer.all.length).to eq 0
        end
        it 'question.answer_countが一つ減っている' do
          expect(Question.find(2).answer_count).to eq 0
        end
      end

      context 'ロールバックした場合' do
        before do
        # 意図的にロールバックする方法が分からなかったので、テスト未達
        end
        # it 'answerのレコード数が変わっていない' do
        # end
        # it 'question.answer_countが変わっていない' do
        # end
      end
    end
  end
end