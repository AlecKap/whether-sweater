require 'rails_helper'

RSpec.describe Weather do
  it 'exists and has attributes' do
    test_weather_data
    weather = Weather.new(test_weather_data)

    expect(weather).to be_a(Weather)
    expect(weather.current_weeather).to be_a(Hash)
    expect(weather.daily_weather).to be_an(Array)
    expect(weather.hourly_weather).to be_an(Array)
    expect(weather.daily_weather.count).to eq(5)
    expect(weather.hourly_weather.count).to eq(24)
  end
end
