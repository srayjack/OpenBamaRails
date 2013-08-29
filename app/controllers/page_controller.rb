class PageController < ApplicationController
  def index
	@short_uri = params[:uri]

	@page = Page.where(:uri_short_name => @short_uri).first

	@title = @page.title

	if @short_uri != 'about'
		add_breadcrumb 'About OpenBama', '/page/about'
	end

	add_breadcrumb @title, ""
  end
end
