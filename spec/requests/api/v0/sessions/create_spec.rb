require 'rails_helper'

RSpec.describe 'can login and create a session' do
  describe 'happy path' do
    it 'can login a user' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      User.create!(user_params)

      login_params = {
        'email': 'whatever@example.com',
        'password': 'password'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      logged_in_user = JSON.parse(response.body, symbolize_names: true)

      expect(logged_in_user).to be_a(Hash)
      expect(logged_in_user).to have_key(:data)
      expect(logged_in_user[:data]).to be_a(Hash)
      expect(logged_in_user[:data]).to have_key(:id)
      expect(logged_in_user[:data][:id]).to be_a(String)
      expect(logged_in_user[:data]).to have_key(:type)
      expect(logged_in_user[:data][:type]).to eq('user')
      expect(logged_in_user[:data]).to have_key(:attributes)
      expect(logged_in_user[:data][:attributes]).to be_a(Hash)
      expect(logged_in_user[:data][:attributes]).to have_key(:email)
      expect(logged_in_user[:data][:attributes][:email]).to be_a(String)
      expect(logged_in_user[:data][:attributes]).to have_key(:api_key)
      expect(logged_in_user[:data][:attributes][:api_key]).to be_a(String)
      expect(logged_in_user[:data][:attributes]).to_not have_key(:password)
      expect(logged_in_user[:data][:attributes]).to_not have_key(:password_confirmation)
      expect(logged_in_user[:data][:attributes]).to_not have_key(:password_digest)
    end
  end

  describe 'sad path' do
    it 'returns an error if email is not found' do
      login_params = {
        'email': 'what@example.com',
        'password': 'password'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end

    it 'returns an error if password is incorrect' do
      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      User.create!(user_params)

      login_params = {
        'email': 'whatever@example.com',
        'password': 'passwo'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end

    it 'returns an error if email is missing' do
      login_params = {
        'email': '',
        'password': 'password'
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end

    it 'returns an error if password is missing' do
      login_params = {
        'email': 'alec@gmail.com',
        'password': ''
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end

    it 'returns an error if email and password are missing' do
      login_params = {
        'email': '',
        'password': ''
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/sessions', headers: headers, params: JSON.generate(login_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end
  end
end
