class ShortenedUrl < ApplicationRecord
  validates :long_url, presence: true
  validates :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    foreign_key: :url_id,
    class_name: :Visit
    
  has_many :visitors,
    through: :visits,
    source: :user

  def self.random_code(user, long_url)
    begin
      short_url = SecureRandom::urlsafe_base64[0, 5]
    end while exists?(short_url: short_url)
    create!(long_url: long_url, short_url: short_url, user_id: user.id)
  end

end
