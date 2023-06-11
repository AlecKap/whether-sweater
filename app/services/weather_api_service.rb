class WeatherApiService
  def get_forecast(lat, long)
    get_url("/v1/forecast.json?q=#{lat},#{long}&days=5")
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |f|
      f.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
