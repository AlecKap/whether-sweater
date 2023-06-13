require 'rails_helper'

RSpec.describe RoadTripFacade do
  describe 'Instance Methods' do
    before :each do
      origin = 'broomfield,co'
      # destination = 'panama city,panama'
      destination = 'colorado springs,co'
      @facade = RoadTripFacade.new(origin, destination)
    end

    describe '#road_trip' do
      it 'returns a road trip object', :vcr do
        expect(@facade.road_trip).to be_a(RoadTrip)
      end
    end

    describe '#all_road_trip_data' do
      it 'returns a hash of road trip data', :vcr do
        expect(@facade.all_road_trip_data).to be_a(Hash)
        expect(@facade.all_road_trip_data).to have_key(:start_city)
        expect(@facade.all_road_trip_data[:start_city]).to be_a(String)
        expect(@facade.all_road_trip_data).to have_key(:end_city)
        expect(@facade.all_road_trip_data[:end_city]).to be_a(String)
        expect(@facade.all_road_trip_data).to have_key(:travel_time)
        expect(@facade.all_road_trip_data[:travel_time]).to be_a(String)
        expect(@facade.all_road_trip_data).to have_key(:weather_at_eta)
        expect(@facade.all_road_trip_data[:weather_at_eta]).to be_a(Hash)
      end
    end

    describe '#travel_time' do
      it 'returns a string of the travel time', :vcr do
        expect(@facade.travel_time).to be_a(String)
      end

      it 'returns impossible route if the route is impossible', :vcr do
        origin = 'broomfield,co'
        destination = 'london,uk'
        facade = RoadTripFacade.new(origin, destination)
        expect(facade.travel_time).to eq('Impossible Route')
      end
    end

    describe '#weather_at_eta' do
      it 'returns a hash of weather data', :vcr do
        expect(@facade.weather_at_eta).to be_a(Hash)
        expect(@facade.weather_at_eta).to have_key(:datetime)
        expect(@facade.weather_at_eta[:datetime]).to be_a(String)
        expect(@facade.weather_at_eta).to have_key(:temperature)
        expect(@facade.weather_at_eta[:temperature]).to be_a(Float)
        expect(@facade.weather_at_eta).to have_key(:condition)
        expect(@facade.weather_at_eta[:condition]).to be_a(String)
      end

      it 'returns an empty hash if the route is impossible', :vcr do
        origin = 'broomfield,co'
        destination = 'london,uk'
        facade = RoadTripFacade.new(origin, destination)

        expect(facade.weather_at_eta).to eq({})
      end
    end
  end
end
