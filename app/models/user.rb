class User < ApplicationRecord
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: { maximum: 255 },
              format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
              uniqueness: { case_sensitive: false }
              
    has_secure_password
    
    #UserからWorkoutlogを見たとき複数存在する＝一対多の関係
    has_many :workoutlogs
    
    #followの関係＝多数対多数の関係を作る
    has_many :relationships
    has_many :followings, through: :relationships, source: :follow
    has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
    has_many :followers, through: :reverses_of_relationship, source: :user
    
    def follow(other_user)
        unless self == other_user
            self.relationships.find_or_create_by(follow_id: other_user.id)
        end
    end

    def unfollow(other_user)
        relationship = self.relationships.find_by(follow_id: other_user.id)
        relationship.destroy if relationship
    end

    def following?(other_user)
        self.followings.include?(other_user)
    end
    
    def feed_workoutlogs
        Workoutlog.where(user_id: self.following_ids + [self.id])
    end
    
    #お気に入り機能
    has_many :favorites
    has_many :likes, through: :favorites, source: :workoutlog
    
    def like(other_workoutlog)
        self.favorites.find_or_create_by(workoutlog_id: other_workoutlog.id)
    end
    
    def unlike(other_workoutlog)
        favorite = self.favorites.find_by(workoutlog_id: other_workoutlog.id)
        favorite.destroy if favorite
    end
        
    def like?(other_workoutlog)
        self.likes.include?(other_workoutlog)
    end
end
