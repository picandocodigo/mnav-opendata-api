class ApplicationController < ActionController::Base
  protect_from_forgery

  def respond(elem)
    respond_to do |format|
      format.json {render :json => elem}
      format.xml {render :xml => elem}
    end
  end

end
