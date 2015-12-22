class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  validates :user_id, :post_id, presence: true
  after_create :send_notification

  private
  def send_notification

      NotificationMailer.subscribe_notification(post.user, post, self).deliver_now
    end
  end

