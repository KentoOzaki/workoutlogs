class Workoutlog < ApplicationRecord
  #userとの紐付け
  belongs_to :user
  
  #validationの作成
  validates :content, presence: true
end
