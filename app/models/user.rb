class User < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(12)
  end
end
