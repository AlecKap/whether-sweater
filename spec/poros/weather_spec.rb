require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    test_forecast_data
    forecast = Forecast.new(test_forecast_data)

    expect(forecast).to be_a(Forecast)
    expect(forecast.current_weather).to be_a(Hash)
    expect(forecast.daily_weather).to be_an(Array)
    expect(forecast.hourly_weather).to be_an(Array)
    expect(forecast.daily_weather.count).to eq(5)
    expect(forecast.hourly_weather.count).to eq(24)
    expect(forecast.id).to eq(nil)
  end
end
