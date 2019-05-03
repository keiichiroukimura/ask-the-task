class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  enum status: { "": 0,未着手: 1, 着手中: 2, 完了: 3 }
  
  scope :search_task, -> (title,status,sort_expired) do
    if title.present? && status.present? 
      where("title like ?","%#{title}%").where(status: status)
    elsif title.present? && status == ""
      where("title like ?","%#{title}%")
    elsif title == "" && status.present? 
      where(status: status)
      #enumでintegerでdbにあるのでstatusキーで値を取得する記載。
    elsif sort_expired.present?
      order(deadline: "ASC")
    else 
      order(created_at: "DESC") 
    end
  end
end
  

