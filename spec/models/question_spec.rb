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

  describe 'アソシエーションのテスト' do
    it '回答モデルとの関係が1:Nとなっている' do
      expect(Question.reflect_on_association(:answers).macro).to eq :has_many
    end
    it 'タグモデルとの関係がN:1となっている' do
      expect(Question.reflect_on_association(:tag).macro).to eq :belongs_to
    end
  end

  describe 'メソッドのテスト' do
    before do
      # テストデータの用意
      @user = create(:user)
      other_user = create(:user)
      tags = []
      tags.push(create(:tag))
      tags.push(create(:tag, name: '新卒', genre: '状態'))
      create(:tag, name: '転職', genre: '状態')
      tags.push(create(:tag, name: '営業', genre: '職種'))
      create(:tag, name: '事務', genre: '職種')
      tags.each do |tag|
        create(:follow_tag, user: @user, tag: tag)
      end
      @question_1 = create(:question, tag: Tag.find(1), answer_count: 2)
      @question_2 = create(:question, tag: Tag.find(2), answer_count: 1)
      create(:question, tag: Tag.find(1))
      create(:question, tag: Tag.find(4))
      create(:question, tag: Tag.find(5))

      @answer_1 = create(:answer, user: @user, question: @question_1)
      @answer_2 = create(:answer, user: @user, question: @question_2)
      create(:answer, user: other_user, question: @question_1)

      @follow_tags = FollowTag.where(user_id: @user)
    end

    describe 'self.return_unanswered_questions(user, follow_tags)' do
      it '意図した配列が返る' do
        result = []
        (3..4).each do |n|
          result.push(Question.find(n))
        end
        expect(Question.return_unanswered_questions(@user, @follow_tags)).to eq result
      end
    end

    describe 'self.return_answered_questions(user, follow_tags)' do
      it '意図した配列が返る' do
        result = []
        result.push([@answer_1.id, @question_1.tag.name, @question_1.body, @answer_1.body, @question_1.answer_count])
        result.push([@answer_2.id, @question_2.tag.name, @question_2.body, @answer_2.body, @question_2.answer_count])
        expect(Question.return_answered_questions(@user, @follow_tags)).to eq result
      end
    end
  end
end