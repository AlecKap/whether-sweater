class Api::V0::RoadTripController < ApplicationController
  def create
    if params[:road_trip][:api_key].blank? || User.find_by(api_key: params[:road_trip][:api_key]).nil?
      render json: ErrorSerializer.serializer('Invalid credentials'), status: :unauthorized
    elsif params[:road_trip][:origin].blank? || params[:road_trip][:destination].blank?
      render json: ErrorSerializer.serializer('Invalid Request'), status: 400
    else
      road_trip = RoadTripFacade.new(params[:road_trip][:origin], params[:road_trip][:destination]).road_trip
      render json: RoadTripSerializer.new(road_trip)
    end
  end
end
