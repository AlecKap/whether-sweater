require 'rails_helper'

RSpec.describe 'Forecast Request' do
  describe 'happy path' do
    it 'retrives forecast data for a given location', :vcr do
      get '/api/v0/forecast?location=cincinatti,oh'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a(Hash)
      expect(data).to have_key(:data)
      expect(data[:data]).to be_a(Hash)
      expect(data[:data]).to have_key(:id)
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq('forecast')
      expect(data[:data]).to have_key(:attributes)

      attrs = data[:data][:attributes]

      expect(attrs).to be_a(Hash)
      expect(attrs).to have_key(:current_weather)
      expect(attrs[:current_weather]).to be_a(Hash)
      expect(attrs[:current_weather]).to have_key(:last_updated)
      expect(attrs[:current_weather][:last_updated]).to be_a(String)
      expect(attrs[:current_weather]).to have_key(:temperature)
      expect(attrs[:current_weather][:temperature]).to be_a(Float)
      expect(attrs[:current_weather]).to have_key(:condition)
      expect(attrs[:current_weather][:condition]).to be_a(String)
      expect(attrs[:current_weather]).to have_key(:icon)
      expect(attrs[:current_weather][:icon]).to be_a(String)
      expect(attrs[:current_weather]).to have_key(:feels_like)
      expect(attrs[:current_weather][:feels_like]).to be_a(Float)
      expect(attrs[:current_weather]).to have_key(:humidity)
      expect(attrs[:current_weather][:humidity]).to be_a(Integer)
      expect(attrs[:current_weather]).to have_key(:visibility)
      expect(attrs[:current_weather][:visibility]).to be_a(Float)
      expect(attrs[:current_weather]).to have_key(:uvi)
      expect(attrs[:current_weather][:uvi]).to be_a(Float)

      expect(attrs).to have_key(:daily_weather)
      expect(attrs[:daily_weather]).to be_an(Array)
      expect(attrs[:daily_weather].count).to eq(6)

      attrs[:daily_weather].each do |day|
        expect(day).to be_a(Hash)
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Float)
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Float)
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)
        expect(day).to have_key(:condition)
        expect(day[:condition]).to be_a(String)
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)
      end

      expect(attrs).to have_key(:hourly_weather)
      expect(attrs[:hourly_weather]).to be_an(Array)
      expect(attrs[:hourly_weather].count).to eq(24)

      attrs[:hourly_weather].each do |hour|
        expect(hour).to be_a(Hash)
        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
        expect(hour[:time].length).to eq(5)
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a(Float)
        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a(String)
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a(String)
      end
    end
  end
end