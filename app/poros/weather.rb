class Weather
  attr_reader :current_weeather,
              :daily_weather,
              :hourly_weather

  def initialize(all_weather_data)
    @current_weeather = all_weather_data[:current_weather]
    @daily_weather = all_weather_data[:daily_weather]
    @hourly_weather = all_weather_data[:hourly_weather]
  end
end
