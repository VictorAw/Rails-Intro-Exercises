class ShortenedUrl < ActiveRecord::Base
  validates :long_url, presence: true, uniqueness: true, length: { maximum: 1024 }
  validates :short_url, length: { maximum: 1024 }
  validates :user_id, presence: true
  validate :five_per_minute, :premium_check

  belongs_to :submitter,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: :Visit,
    primary_key: :id,
    foreign_key: :url_id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :taggings,
    class_name: :Tagging,
    primary_key: :id,
    foreign_key: :url_id

  has_many :topics,
    through: :taggings,
    source: :topic


  def self.random_code
    code = SecureRandom::urlsafe_base64

    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom::urlsafe_base64
    end

    code
  end

  def self.purge
    stale_visits = Visit.where("created_at < ?", 5.minutes.ago)

    visits = Visit.where("created_at > ?", 5.minutes.ago)
    recently_visited_urls = visits.map { |visit| visit.url_id }
    stale_urls = ShortenedUrl.where("id NOT IN (?)", recently_visited_urls)


    stale_urls.each { |url| url.destroy }
    stale_visits.each { |visit| visit.destroy }
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code)
  end

  def num_clicks
    Visit.where("visits.url_id = ?", id).count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("visits.created_at > ?", 10.minutes.ago).count
    # recent_clicks = Visit.where("created_at > ?", 10.minutes.ago)
    # recent_clicks.where("visits.url_id = ?", id).select(:user_id).distinct.count
  end

  def five_per_minute
    recent = ShortenedUrl.where("created_at > ?", 5.minutes.ago)
    recent.where("user_id = ?", user_id).distinct
    recent = recent.count

    if (recent == 5)
      errors[:posting_too_fast] << "Too many posts! Slooow Down!"
    end
  end

  def premium_check
    urls = ShortenedUrl.where("user_id = ?", user_id).distinct.count


    if urls >= 5 && !User.find(user_id).premium
      errors[:cheapskate] << "Too many posts! Join the elite. Upgrade to premium."
    end
  end
end
