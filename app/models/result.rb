class Result < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 25 }
  
  def self.search(search)
    if search
      Result.where('content LIKE(?)', "%#{search}%")
    else
      Result.all
    end
  end
end
