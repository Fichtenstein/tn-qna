FactoryGirl.define do
  factory :answer, class: 'Answer' do
    body "MyText"
    question
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
    question
  end
end
