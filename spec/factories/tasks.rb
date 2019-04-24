FactoryBot.define do
  factory :task do
    title { "test_task_01" }
    content { "testtesttest" }
    deadline { "4月24日"}
  end
  factory :second_task, class: Task do
    title { "test_task_02" }
    content { "samplesample" }
    deadline { "4月25日"}
  end
end