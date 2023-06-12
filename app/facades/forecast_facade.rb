class ForecastFacade
  def initialize(location)
    @location = location
  end

  def forecast
    Forecast.new(all_weather_data)
  end

  def all_weather_data
    {
      current_weather: current_weather_data,
      daily_weather: daily_weather_data,
      hourly_weather: hourly_weather_data
    }
  end

  def current_weather_data
    {
      last_updated: weather_data(lat_long)[:current][:last_updated],
      temperature: weather_data(lat_long)[:current][:temp_f],
      feels_like: weather_data(lat_long)[:current][:feelslike_f],
      humidity: weather_data(lat_long)[:current][:humidity],
      uvi: weather_data(lat_long)[:current][:uv],
      visibility: weather_data(lat_long)[:current][:vis_miles],
      condition: weather_data(lat_long)[:current][:condition][:text],
      icon: weather_data(lat_long)[:current][:condition][:icon]
    }
  end

  def daily_weather_data
    weather_data(lat_long)[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly_weather_data
    weather_data(lat_long)[:forecast][:forecastday][0][:hour].map do |day|
      {
        time: day[:time][-5..-1],
        temperature: day[:temp_f],
        conditions: day[:condition][:text],
        icon: day[:condition][:icon]
      }
    end
  end

  def lat_long
    "#{map_data[:results][0][:locations][0][:latLng][:lat]},#{map_data[:results][0][:locations][0][:latLng][:lng]}"
  end

  private
  
  def map_service
    @_map_service ||= MapquestService.new
  end

  def weather_service
    @_weather_service ||= ForecastApiService.new
  end

  def weather_data(lat_long)
    @_weather_data ||= weather_service.get_forecast(lat_long)
  end

  def map_data
    @_map_data ||= map_service.get_lat_long(@location)
  end
end
