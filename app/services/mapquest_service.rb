class MapquestService
  def get_lat_long(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def get_road_trip_data(origin, destination)
    get_url("/directions/v2/route?from=#{origin}&to=#{destination}")
  end

  private

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |f|
      f.params['key'] = ENV['MAPQUEST_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
