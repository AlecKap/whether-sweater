require 'rails_helper'

RSpec.describe 'can create a user' do
  describe 'happy path' do
    it 'can create a user' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      created_user = User.last

      expect(response).to be_successful
      expect(response.status).to eq(201)

      expect(created_user.email).to eq(user_params[:email])
      expect(created_user.api_key).to be_a(String)
      expect(created_user.api_key.length).to eq(24)
    end
  end

  describe 'sad path' do
    it 'returns an error if email is already taken' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      User.create!(user_params)
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Validation failed: Email has already been taken')
    end

    it 'returns an error if passwords do not match' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'pass'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it 'returns an error if email is missing' do
      user_params = {
        email: '',
        password: 'password',
        password_confirmation: 'password'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq("Validation failed: Email can't be blank")
    end

    it 'returns an error if password is missing' do
      user_params = {
        email: 'alec@gmail.com',
        password: '',
        password_confirmation: 'password'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq("Validation failed: Password can't be blank")
    end

    it 'returns an error if password confirmation is missing' do
      user_params = {
        email: 'alec@gmail.com',
        password: 'password',
        password_confirmation: ''
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/users', headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq("Validation failed: Password confirmation doesn't match Password")
    end
  end
end
