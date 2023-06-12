require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_confirmation_of(:password) }
    it { should have_secure_password }
  end

  describe 'authentication' do
    it 'checks for and stores password securly' do
      user = User.create(email: 'meg@test.com',
                         password: 'password123',
                         password_confirmation: 'password123')

      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq('password123')
    end
  end
end
