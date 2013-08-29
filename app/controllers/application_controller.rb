class ApplicationController < ActionController::Base

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}", layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
  

  protect_from_forgery

  protected
  def add_breadcrumb name, url = ''
    @breadcrumbs ||= []
    url = eval(url) if url =~ /_path|_url|@/
    @breadcrumbs << [name, url]
  end

  def self.add_breadcrumb name, url, options = {}
    before_filter options do |controller|
      controller.send(:add_breadcrumb, name, url)
    end
  end

  add_breadcrumb 'Home', '/'

end
