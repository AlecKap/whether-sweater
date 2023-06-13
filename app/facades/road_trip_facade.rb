class RoadTripFacade < ForecastFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip
    RoadTrip.new(all_road_trip_data)
  end

  def all_road_trip_data
    {
      start_city: @origin,
      end_city: @destination,
      travel_time: travel_time,
      weather_at_eta: weather_at_eta
    }
  end

  def travel_time
    if road_trip_data[:route][:routeError].present?
      'Impossible Route'
    else
      road_trip_data[:route][:formattedTime]
    end
  end

  def weather_at_eta
    if travel_time == 'Impossible Route'
      {}
    else
      {
        datetime: arival_weather_data[:forecast][:forecastday][0][:hour][0][:time],
        temperature: arival_weather_data[:forecast][:forecastday][0][:hour][0][:temp_f],
        condition: arival_weather_data[:forecast][:forecastday][0][:hour][0][:condition][:text]
      }
    end
  end

  private

  def lat_long
    "#{lat_long_data[:results][0][:locations][0][:latLng][:lat]},#{lat_long_data[:results][0][:locations][0][:latLng][:lng]}"
  end

  def arival_date
    arival_date_and_hour[0..9]
  end

  def arival_hour
    hour = arival_date_and_hour[11..12].to_i
    hour + 1 if arival_date_and_hour[14..15].to_i >= 30
    hour
  end

  def arival_date_and_hour
    trip_time = travel_time[0..1].to_i
    trip_time += 1 if travel_time[3..4].to_i >= 30
    date = DateTime.parse(weather_data(lat_long)[:location][:localtime])

    arival_date_hour = date + trip_time.hours
    arival_date_hour.strftime('%Y-%m-%d %H:%M:%S')
  end

  def arival_weather_data
    @_arival_weather_data ||= weather_service.get_forecast_by_location_date_hour(@destination, arival_date, arival_hour)
  end

  def road_trip_data
    @_road_trip_data ||= map_service.get_road_trip_data(@origin, @destination)
  end

  def lat_long_data
    @_lat_long_data ||= map_service.get_lat_long(@destination)
  end
end
