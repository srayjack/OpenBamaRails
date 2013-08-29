class LobbyistController < ApplicationController
  def index

	@id = params[:id]

	@lobbyist = Lobbyist.find(@id)


	cookies[:visitor] = PageViewProcess.process_page_view('lobbyist', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])


	@current_clients = Client.includes(:lobbyist_clients).where('lobbyist_client.lobbyist_id = ?', @id).where('lobbyist_client.is_active = 1').order('lobbyist_client.date_added,lobbyist_client.inactive_date')

	@past_clients = Client.includes(:lobbyist_clients).where('lobbyist_client.lobbyist_id = ?', @id).where('lobbyist_client.is_active = 0').order('lobbyist_client.date_added,lobbyist_client.inactive_date')

	@registrations = LobbyistRegistration.where(:lobbyist_id => @id)

	@title = 'Lobbyist Detail for ' + @lobbyist.display_name

	add_breadcrumb "Lobbyists", "/lobbyists"

	add_breadcrumb @lobbyist.display_name, ""
  end
end
