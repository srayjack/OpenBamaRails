class ClientController < ApplicationController
  def index

	@id = params[:id]
	@client = Client.find(@id)


	cookies[:visitor] = PageViewProcess.process_page_view('client', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])

	@current_lobbyists = Lobbyist.includes(:lobbyist_clients).where('lobbyist_client.client_id = ?', @id).where('lobbyist_client.is_active = 1')
	@past_lobbyists = Lobbyist.includes(:lobbyist_clients).where('lobbyist_client.client_id = ?', @id).where('lobbyist_client.is_active = 0')

	@title = 'Client Detail for ' + @client.display_name
	
	add_breadcrumb "Lobbyists' Clients", '/clients'
	
	add_breadcrumb @client.display_name, ""
  end
end
