class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_invalid(error)
    render json: ErrorSerializer.serializer(error), status: :bad_request
  end
end
