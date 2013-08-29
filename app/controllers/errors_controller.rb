class ErrorsController < ApplicationController
def error_404
    @not_found_path = params[:not_found]
    @title = "Page Not Found - " + @not_found_path
  end

  def error_500
  	@title = "Oops!"
  end
end
