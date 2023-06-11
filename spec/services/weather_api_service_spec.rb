require 'rails_helper'

RSpec.describe WeatherApiService do
  describe 'instance methods' do
    describe '#get_forecast' do
      it 'returns forecast data for a given lat and long', :vcr do
        lat = 39.4389
        long = -108.0647
        results = WeatherApiService.new.get_forecast(lat, long)

        expect(results).to be_a(Hash)
        expect(results).to have_key(:current)

        current = results[:current]
        expect(current).to be_a(Hash)
        expect(current).to have_key(:last_updated)
        expect(current[:last_updated]).to be_a(String)
        expect(current).to have_key(:temp_f)
        expect(current[:temp_f]).to be_a(Float)
        expect(current).to have_key(:condition)
        expect(current[:condition]).to be_a(Hash)
        expect(current[:condition]).to have_key(:text)
        expect(current[:condition][:text]).to be_a(String)
        expect(current[:condition]).to have_key(:icon)
        expect(current[:condition][:icon]).to be_a(String)
        expect(current).to have_key(:feelslike_f)
        expect(current[:feelslike_f]).to be_a(Float)
        expect(current).to have_key(:humidity)
        expect(current[:humidity]).to be_a(Integer)
        expect(current).to have_key(:vis_miles)
        expect(current[:vis_miles]).to be_a(Float)
        expect(current).to have_key(:uv)
        expect(current[:uv]).to be_a(Float)

        expect(results).to have_key(:forecast)
        forecast = results[:forecast]

        expect(forecast).to be_a(Hash)
        expect(forecast).to have_key(:forecastday)

        forecastday = forecast[:forecastday]
        expect(forecastday).to be_an(Array)
        expect(forecastday.count).to eq(5)
        expect(forecastday[0]).to have_key(:date)
        expect(forecastday[0][:date]).to be_a(String)
        expect(forecastday[0]).to have_key(:day)

        day = forecastday[0][:day]
        expect(day).to be_a(Hash)
        expect(day).to have_key(:maxtemp_f)
        expect(day[:maxtemp_f]).to be_a(Float)
        expect(day).to have_key(:mintemp_f)
        expect(day[:mintemp_f]).to be_a(Float)
        expect(day).to have_key(:condition)
        expect(day[:condition]).to be_a(Hash)
        expect(day[:condition]).to have_key(:text)
        expect(day[:condition][:text]).to be_a(String)
        expect(day[:condition]).to have_key(:icon)
        expect(day[:condition][:icon]).to be_a(String)
        expect(forecastday[0][:astro]).to be_a(Hash)
        expect(forecastday[0][:astro]).to have_key(:sunrise)
        expect(forecastday[0][:astro][:sunrise]).to be_a(String)
        expect(forecastday[0][:astro]).to have_key(:sunset)
        expect(forecastday[0][:astro][:sunset]).to be_a(String)
        expect(forecastday[0]).to have_key(:hour)

        hour = forecastday[0][:hour]
        expect(hour).to be_an(Array)
        expect(hour.count).to eq(24)
        expect(hour[0]).to have_key(:time)
        expect(hour[0][:time]).to be_a(String)
        expect(hour[0]).to have_key(:temp_f)
        expect(hour[0][:temp_f]).to be_a(Float)
        expect(hour[0]).to have_key(:condition)
        expect(hour[0][:condition]).to be_a(Hash)
        expect(hour[0][:condition]).to have_key(:text)
        expect(hour[0][:condition][:text]).to be_a(String)
        expect(hour[0][:condition]).to have_key(:icon)
        expect(hour[0][:condition][:icon]).to be_a(String)
      end

      it 'does not return unnecessary data', :vcr do
        lat = 39.4389
        long = -108.0647
        results = WeatherApiService.new.get_forecast(lat, long)

        expect(results).to be_a(Hash)
        expect(results[:forecast][:forecastday]).to be_an(Array)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:maxtemp_c)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:mintemp_c)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:avgtemp_c)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:maxwind_kph)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:totalprecip_mm)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:avgvis_km)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:daily_will_it_rain)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:daily_chance_of_rain)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:daily_will_it_snow)
        expect(results[:forecast][:forecastday][0][:day]).to_not have_key(:daily_chance_of_snow)

        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:time_epoch)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:temp_c)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:feelslike_c)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:wind_kph)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:wind_degree)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:wind_dir)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:pressure_mb)
        expect(results[:forecast][:forecastday][0][:hour][0]).to_not have_key(:precip_mm)
      end
    end
  end
end
