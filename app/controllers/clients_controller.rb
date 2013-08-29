class ClientsController < ApplicationController
  def index
	@lobbyist_count = Lobbyist.where(:active => 1 ).count()
	@client_count = Client.includes(:lobbyist_clients).where('lobbyist_client.is_active = 1').count()
	@clients = Client.includes(:lobbyist_clients).where('lobbyist_client.is_active = 1')
	@most_viewed_client = PageView.joins(:client).select('client_id,count(*) as page_views' ).where('page_views.client_id is not null').group('page_views.client_id').order('count(*) desc').first

	@clients = @clients.paginate(:page => params[:page], :per_page => 50)
	@title = "Lobbyists' Clients"

	add_breadcrumb @title, ""
  end
end
