class Task < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, length: {maximum: 20}, presence: true, uniqueness: true
end
