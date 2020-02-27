class Workoutlog < ApplicationRecord
  #userとの紐付け
  belongs_to :user
  
  #validationの作成
  validates :content, presence: true
  
  #お気に入り機能
  has_many :reverses_of_favorite, class_name: 'favorite', foreign_key: 'workoutlog_id'
  has_many :liked, through: :reverses_of_favorite, source: :user
  has_many :favorites, dependent: :destroy
end
