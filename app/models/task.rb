class Task < ApplicationRecord
  validates :title, presence: true
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_labels, through: :favorites, source: :label
  
  scope :search_title, ->(title) {
    return if title.blank? 
    where("title like ?","%#{title}%")
  }
  scope :search_status, ->(status) {
    return if status.blank?
    where(status: status)
  }

  # scope :search_label, ->(label_id) {
  #   return if label_id.blank?
  #   where(content: label_id)
  # }
  
  scope :sort_priority, ->(sort_priority) {
    order(priority: "ASC" ) 
  }
  scope :sort_expired, -> (sort_expired) { 
    order(deadline: "ASC") 
  }

  # scope :my_tasks, -> (user_id) { 
  #   where(user_id: user_id) 
  # }

  enum priority: {高: 0,中: 1, 低: 2 }
  enum status: {未着手: 0, 着手中: 1, 完了: 2 }
  
  # scope :search_task, -> (title,status,sort_expired) do
  #   if title.present? && status.present? 
  #     where("title like ?","%#{title}%").where(status: status)
  #   elsif title.present? && status == ""
  #     where("title like ?","%#{title}%")
  #   elsif title == "" && status.present? 
  #     where(status: status)
  #     #enumでintegerでdbにあるのでstatusキーで値を取得する記載。
  #   elsif sort_expired.present?
  #     order(deadline: "ASC")
  #   else 
  #     order(created_at: "DESC") 
  #   end
  # end
end
  

