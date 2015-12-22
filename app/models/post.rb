class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  has_many :subscriptions
  has_many :subscribers, source: :user, through: :subscriptions
  #has_and_belongs_to_many :categories
  has_many :categories_posts
  has_many :categories, through: :categories_posts
  validates :title, :body, presence: true

  scope :reverse_order, -> (order){ order(created_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  after_create :subscribed_auhtor


public
 def categories_titles
  #categories.map(&:title).join ', '
  categories.pluck(:title).join ', '
 end

  protected

  def subscribe_author
    user.subscribe_to(self)
  end
end