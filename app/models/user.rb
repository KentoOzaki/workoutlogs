class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: { maximum: 255 },
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
              uniqueness: { case_sensitive: false }
              
    has_secure_password
    
    #UserからWorkoutlogを見たとき複数存在する＝一対多の関係
    has_many :workoutlogs
    
end
