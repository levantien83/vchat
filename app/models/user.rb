class User < ApplicationRecord  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_insensitive: false}
  validates :password, length: { in: 6..20 }
  has_secure_password
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :friend_requests, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :followers, through: :friend_requests, :source => :user
  

  def recieved_messages
    Message.where(to_id: self)    
  end

  def sent_messages
    Message.where(from_id: self)
  end

  def latest_recieved_messages(n)
    recieved_messages.order(created_at: :desc).limit(n)
  end

  def unread_messages
    recieved_messages.unread
  end

  def true_friendships
    self.friendships.where(acceptance: true) + self.friend_requests.where(acceptance: true)
  end

  def true_friends
    @true_friends = []
    self.friendships.where(acceptance: true).map do |friendship|
      true_friend = User.find(friendship.friend_id)
      @true_friends = @true_friends + [true_friend]
    end

    self.friend_requests.where(acceptance: true).map do |friendship|
      true_friend = User.find(friendship.user_id)
      @true_friends = @true_friends + [true_friend]
    end
    return @true_friends
  end
end