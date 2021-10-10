FactoryBot.define do
  factory :answer do
    body { '素直なところです' }
    user
    question
  end
end