class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  before_validation{ email.downcase! }
  has_many :tasks, dependent: :destroy
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  after_destroy :ensure_an_admin_remains

  private

  def ensure_an_admin_remains
    if User.where(admin: "true").count.zero?
      raise "最後の管理者は削除できません！"
    end
  end
end
