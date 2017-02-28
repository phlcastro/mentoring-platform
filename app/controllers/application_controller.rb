class ApplicationController < ActionController::API
  include Knock::Authenticable
  include RescueConcern
end
