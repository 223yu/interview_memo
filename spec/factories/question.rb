FactoryBot.define do
  factory :question do
    body { '長所を教えてください' }
    answer_count { 0 }
    tag
  end
end