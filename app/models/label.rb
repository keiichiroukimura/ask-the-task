class Label < ApplicationRecord
  validates :content, presence: true
  validates :content, uniqueness: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_tasks, through: :favorites, source: :task
end
