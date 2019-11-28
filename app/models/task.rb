class Task < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :title, length: {maximum: 20}, presence: true, uniqueness: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      task = find_by(id: row["id"]) || new
      # CSVからデータを取得し、設定する
      task.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      task.save
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["title", "user_id"]
  end
end
