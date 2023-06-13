require 'rails_helper'

RSpec.describe RoadTrip do
  it 'exists and has attributes' do
    data = {
      start_city: 'Denver,CO',
      end_city: 'Pueblo,CO',
      travel_time: '1:44:22',
      weather_at_eta: {
        date_time: '2021-03-07 21:00:00 -0700',
        temperature: '55.42 F',
        condition: 'Clear'
      }
    }
    road_trip = RoadTrip.new(data)

    expect(road_trip).to be_a(RoadTrip)
    expect(road_trip.start_city).to eq('Denver,CO')
    expect(road_trip.end_city).to eq('Pueblo,CO')
    expect(road_trip.travel_time).to eq('1:44:22')
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta[:date_time]).to eq('2021-03-07 21:00:00 -0700')
    expect(road_trip.weather_at_eta[:temperature]).to eq('55.42 F')
    expect(road_trip.weather_at_eta[:condition]).to eq('Clear')
    expect(road_trip.id).to eq(nil)
    expect(road_trip.start_city).to be_a(String)
    expect(road_trip.end_city).to be_a(String)
    expect(road_trip.travel_time).to be_a(String)
    expect(road_trip.weather_at_eta[:date_time]).to be_a(String)
    expect(road_trip.weather_at_eta[:temperature]).to be_a(String)
    expect(road_trip.weather_at_eta[:condition]).to be_a(String)
  end
end
