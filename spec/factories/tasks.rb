FactoryBot.define do
  # factory :user do
  #   name { "ジミヘンドリクス" }
  #   email { "crybaby@email.com" }
  #   password { "111111" }
  # end
  factory :task do
    title { "test_task_01" }
    content { "testtesttest" }
    deadline { Date.today }
    status { "着手中" }
    priority {"高"}
  end
  factory :second_task, class: Task do
    title { "test_task_02" }
    content { "samplesample" }
    deadline { Date.today + 1}
    status { "未着手" }
    priority {"中"}
  end
#   factory :third_task, class: Task do
#     #user_id {4}
#     title { "AAA" }
#     content { "samplesample" }
#     status { "着手中" }
#     priority {"低"}
#   end
#   factory :forth_task, class: Task do
# #    user_id {5}
#     title { "BBB" }
#     content { "testtesttest" }
#     status { "未着手" }
#   end
#   factory :fifth_task, class: Task do
#    # user_id {6}
#     title { "AAABBB" }
#     content { "samplesample" }
#     status { "着手中" }
#   end
end