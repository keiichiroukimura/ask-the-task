FactoryBot.define do
  factory :user do
    name { "ジミヘンドリクス" }
    email { "crybaby@email.com" }
    password { "111111" }
    admin {true}
  end
  factory :second_user, class: User do
    name { "ポールマッカートニー" }
    email { "poul@email.com" }
    password { "222222" }
  end
  factory :third_user, class: User do
    id {4}
    name { "ジェリーガルシア" }
    email { "jerry@email.com" }
    password { "333333" }
  end
  factory :forth_user, class: User do
    id {5}
    name { "ジェイムステイラー" }
    email { "james@email.com" }
    password { "444444" }
  end
  factory :fifth_user, class: User do
    id {6}
    name { "オーティスレディング" }
    email { "otis@email.com" }
    password { "555555" }
  end
end
