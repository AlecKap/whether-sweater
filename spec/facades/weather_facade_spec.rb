require 'rails_helper'

RSpec.describe ForecastFacade do
  describe 'instance methods' do
    before :each do
      @facade = ForecastFacade.new('broomfield,co')
    end

    describe 'forecast' do
      it 'returns a Forecast object with the weather details for a given location', :vcr do
        expect(@facade.forecast).to be_a(Forecast)
      end
    end

    describe 'lat_long' do
      it 'returns the latitude for a given location', :vcr do
        expect(@facade.lat_long).to eq('39.92086,-105.07058')
        expect(@facade.lat_long).to be_a(String)
      end
    end

    describe 'current_weather_data' do
      it 'returns the current weather data for a given location', :vcr do
        expect(@facade.current_weather_data).to be_a(Hash)
        expect(@facade.current_weather_data).to have_key(:last_updated)
        expect(@facade.current_weather_data[:last_updated]).to be_a(String)
        expect(@facade.current_weather_data).to have_key(:temperature)
        expect(@facade.current_weather_data[:temperature]).to be_a(Float)
        expect(@facade.current_weather_data).to have_key(:condition)
        expect(@facade.current_weather_data[:condition]).to be_a(String)
        expect(@facade.current_weather_data).to have_key(:icon)
        expect(@facade.current_weather_data[:icon]).to be_a(String)
        expect(@facade.current_weather_data).to have_key(:feels_like)
        expect(@facade.current_weather_data[:feels_like]).to be_a(Float)
        expect(@facade.current_weather_data).to have_key(:humidity)
        expect(@facade.current_weather_data[:humidity]).to be_a(Integer)
        expect(@facade.current_weather_data).to have_key(:visibility)
        expect(@facade.current_weather_data[:visibility]).to be_a(Float)
        expect(@facade.current_weather_data).to have_key(:uvi)
        expect(@facade.current_weather_data[:uvi]).to be_a(Float)
      end
    end

    describe 'daily_weather_data' do
      it 'returns the daily weather data for a given location', :vcr do
        expect(@facade.daily_weather_data).to be_an(Array)
        expect(@facade.daily_weather_data.count).to eq(6)
        @facade.daily_weather_data.each do |day|
          expect(day).to be_a(Hash)
          expect(day).to have_key(:date)
          expect(day[:date]).to be_a(String)
          expect(day).to have_key(:max_temp)
          expect(day[:max_temp]).to be_a(Float)
          expect(day).to have_key(:min_temp)
          expect(day[:min_temp]).to be_a(Float)
          expect(day).to have_key(:condition)
          expect(day[:condition]).to be_a(String)
          expect(day).to have_key(:icon)
          expect(day[:icon]).to be_a(String)
          expect(day).to have_key(:sunrise)
          expect(day[:sunrise]).to be_a(String)
          expect(day).to have_key(:sunset)
          expect(day[:sunset]).to be_a(String)
        end
      end
    end

    describe 'hourly_weather_data' do
      it 'returns the hourly weather data for a given location', :vcr do
        expect(@facade.hourly_weather_data).to be_an(Array)
        expect(@facade.hourly_weather_data.count).to eq(24)
        @facade.hourly_weather_data.each do |hour|
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
end
