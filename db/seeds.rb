require 'csv'

# develop環境のみ利用
# CSV.foreach('db/csv/user.csv', headers: true) do |row|
#   User.create!(
#     name: row['name'],
#     email: row['email'],
#     password: row['password'],
#   )
# end

CSV.foreach('db/csv/tag.csv', headers: true) do |row|
  Tag.create!(
    name: row['name'],
    genre: row['genre'],
  )
end

# develop環境のみ利用
# CSV.foreach('db/csv/question.csv', headers: true) do |row|
#   Question.create!(
#     tag_id: row['tag_id'],
#     body: row['body'],
#     answer_count: row['answer_count'],
#   )
# end

# 本番環境用
CSV.foreach('db/csv/question(production).csv', headers: true) do |row|
  Question.create!(
    tag_id: row['tag_id'],
    body: row['body'],
    answer_count: row['answer_count'],
  )
end

# develop環境のみ利用
# CSV.foreach('db/csv/answer.csv', headers: true) do |row|
#   Answer.create!(
#     user_id: row['user_id'],
#     question_id: row['question_id'],
#     body: row['body'],
#   )
# end

# develop環境のみ利用
# CSV.foreach('db/csv/follow_tag.csv', headers: true) do |row|
#   FollowTag.create!(
#     user_id: row['user_id'],
#     tag_id: row['tag_id'],
#   )
# end