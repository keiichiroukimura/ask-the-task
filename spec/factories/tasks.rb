FactoryBot.define do
  factory :task do
    title { "test_task_01" }
    content { "testtesttest" }
    status { "着手中" }
    priority {"高"}
  
  end
  factory :second_task, class: Task do
    title { "test_task_02" }
    content { "samplesample" }
    status { "未着手" }
    priority {"中"}
  end
  factory :third_task, class: Task do
    title { "AAA" }
    content { "samplesample" }
    status { "着手中" }
    priority {"低"}
  end
  factory :forth_task, class: Task do
    title { "BBB" }
    content { "testtesttest" }
    status { "未着手" }
  end
  factory :fifth_task, class: Task do
    title { "AAABBB" }
    content { "samplesample" }
    status { "着手中" }
  end
end