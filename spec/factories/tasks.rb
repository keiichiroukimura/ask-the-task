FactoryBot.define do
  factory :task do
    title { "資料作成" }
    content { "A会社プレゼン用資料作成" }
  end
  factory :second_task, class: Task do
    title { "打ち合わせ" }
    content { "床下配管工事日程調整打ち合わせ" }
  end
end