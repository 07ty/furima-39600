FactoryBot.define do
  factory :user do
    nick_name {'ニックネーム'}
    first_name {'名'}
    last_name {'姓'}
    first_kana {'メイ'}
    last_kana {'セイ'}
    birthday {'1998-07-19'}
    email {'abc123@email.com'}
    password {'w5Qd2LGHQ'}
    password_confirmation {'w5Qd2LGHQ'}
  end
end
