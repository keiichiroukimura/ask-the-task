FactoryBot.define do
  factory :task do
    title { "test_task_01" }
    content { "testtesttest" }
  end
  factory :second_task, class: Task do
    title { "test_task_02" }
    content { "samplesample" }
  end
end