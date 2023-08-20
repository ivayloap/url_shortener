module Errors
  module ErrorHandling
    def self.included(base)
      base.class_eval do
        # rescue_from StandardError do |e|
        #   respond('Internal server error', :internal_server_error)
        # end

        rescue_from InvalidUrlError do |e|
          respond(e, :bad_request)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          respond('Resource not found', :bad_request)
        end
      end
    end

    private

    def respond(message, status)
      render json: {error: message}, status: status
    end
  end
end