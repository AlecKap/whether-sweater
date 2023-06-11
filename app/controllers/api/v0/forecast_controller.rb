class Api::V0::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.new(params[:location]).forecast
    render json: ForecastSerializer.new(forecast)
  end
end