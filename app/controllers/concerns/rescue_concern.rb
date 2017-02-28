module RescueConcern
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue_server
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_parameters
    rescue_from ActiveRecord::RecordInvalid, with: :rescue_record_invalid

    def rescue_bad_parameters(e)
      render json: { error: e.message }, status: :bad_request
    end

    def rescue_record_invalid(e)
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def rescue_server(e)
      render json: { error: e.message }, status: :internal_server_error
    end
  end
end
