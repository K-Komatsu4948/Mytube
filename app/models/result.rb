class Result < ApplicationRecord
  validates :content, presence: true, length: { maximum: 25 }
  
  def self.content(content)
      return Result.all unless content
      Result.where(['content LIKE ?', "%#{content}%"])
  end
end
