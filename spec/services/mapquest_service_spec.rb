require 'rails_helper'

RSpec.describe MapquestService do
  describe 'instance methods' do
    describe '#get_lat_long' do
      it 'returns lat and long for a given location', :vcr do
        location = 'broomfield,co'
        results = MapquestService.new.get_lat_long(location)

        expect(results).to be_a(Hash)
        expect(results).to have_key(:results)
        expect(results[:results]).to be_an(Array)
        expect(results[:results][0]).to have_key(:locations)
        expect(results[:results][0][:locations]).to be_an(Array)
        expect(results[:results][0][:locations][0]).to have_key(:latLng)
        expect(results[:results][0][:locations][0][:latLng]).to be_a(Hash)
        expect(results[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(results[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(results[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)
        expect(results[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
      end
    end

    describe 'get_road_trip_data' do 
      it 'returns road trip data for a given origin and destination', :vcr do
        origin = 'broomfield,co'
        destination = 'colorado springs,co'

        road_trip_data = MapquestService.new.get_road_trip_data(origin, destination)

        expect(road_trip_data).to be_a(Hash)
        expect(road_trip_data).to have_key(:route)
        expect(road_trip_data[:route]).to be_a(Hash)
        expect(road_trip_data[:route]).to have_key(:formattedTime)
        expect(road_trip_data[:route][:formattedTime]).to be_a(String)
      end
    end
  end
end
