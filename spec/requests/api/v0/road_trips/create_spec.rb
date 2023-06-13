require 'rails_helper'

RSpec.describe 'can create a road trip' do
  describe 'happy path' do
    it 'can create a road trip', :vcr do
      user_params = {
        email: 'alec@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      user = User.create!(user_params)

      travel_details = {
        origin: 'denver,co',
        destination: 'pueblo,co',
        api_key: "#{user.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(travel_details)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip_data = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip_data).to be_a(Hash)
      expect(road_trip_data).to have_key(:data)
      expect(road_trip_data[:data]).to be_a(Hash)

      road_trip = road_trip_data[:data]

      expect(road_trip).to have_key(:id)
      expect(road_trip[:id]).to eq(nil)
      expect(road_trip).to have_key(:type)
      expect(road_trip[:type]).to eq('road_trip')
      expect(road_trip).to have_key(:attributes)
      expect(road_trip[:attributes]).to be_a(Hash)

      attributes = road_trip[:attributes]

      expect(attributes).to have_key(:start_city)
      expect(attributes).to have_key(:end_city)
      expect(attributes).to have_key(:travel_time)
      expect(attributes).to have_key(:weather_at_eta)

      arival_weather = attributes[:weather_at_eta]

      expect(arival_weather).to have_key(:temperature)
      expect(arival_weather).to have_key(:datetime)
      expect(arival_weather).to have_key(:condition)
    end
  end

  describe 'sad path' do
    it 'returns an error if api key is not found' do
      user_params = {
        email: 'alec@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      user = User.create!(user_params)

      travel_details = {
        origin: 'denver,co',
        destination: 'pueblo,co',
        api_key: ""
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(travel_details)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end

    it 'returns an error if api key does not match user' do
      user_params = {
        email: 'alec@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      user = User.create!(user_params)

      travel_details = {
        origin: 'denver,co',
        destination: 'pueblo,co',
        api_key: "3453476586ujyuhbr6h68"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(travel_details)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid credentials')
    end

    it 'returns an error if origin is not found' do
      user_params = {
        email: 'alec@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      user = User.create!(user_params)

      travel_details = {
        origin: '',
        destination: 'pueblo,co',
        api_key: "#{user.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(travel_details)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid Request')
    end

    it 'returns an error if destination is not found' do
      user_params = {
        email: 'alec@example.com',
        password: 'password',
        password_confirmation: 'password'
      }
      user = User.create!(user_params)

      travel_details = {
        origin: 'denver,co',
        destination: '',
        api_key: "#{user.api_key}"
      }
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/road_trip', headers: headers, params: JSON.generate(travel_details)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error_data = JSON.parse(response.body, symbolize_names: true)

      expect(error_data[:errors][0][:details]).to eq('Invalid Request')
    end
  end
end
