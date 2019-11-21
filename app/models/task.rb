class Task < ApplicationRecord
  validates :title, length: {maximum: 20}
  # validates :title, presence: true
end
