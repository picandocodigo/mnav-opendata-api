# Public - Isolate general controller methods here.
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Public - Isolates format for responds from controllers
  def respond(elem)
    respond_to do |format|
      format.json {render :json => elem}
      format.xml {render :xml => elem}
    end
  end

end
