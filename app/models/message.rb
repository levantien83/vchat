class Message < ApplicationRecord
  belongs_to :from, class_name: 'User'
  belongs_to :to, class_name: 'User'
  scope :unread, -> { where(read_at: nil) }

  def mark_as_read!
    self.read_at = Time.now
    save!
  end

  def read?
    read_at
  end

  def from_email
    @from_user = User.find(self.from_id)
    @from_user.email
  end

  def to_email
    @to_user = User.find(self.to_id)
    @to_user.email
  end
end
