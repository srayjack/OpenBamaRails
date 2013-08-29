class LobbyistsController < ApplicationController
	def index
		@active_statuses = params[:statuses]
		@state = params[:state]
		@year = params[:year]

		@last_name = params[:last_name]

		@show_active = false
		@show_inactive = false

		if @active_statuses
			@active_statuses.each do |s|
				if s == '1'
					@show_active = true
				elsif s == '0'
					@show_inactive = true
				end
			end
		else
			@show_active = true
		end

		
		if @show_active and @show_inactive
			@lobbyists = Lobbyist.joins(:lobbyist_registrations).where('lobbyist_registrations.is_active = 1 or lobbyist_registrations.is_active = 0')
		elsif @show_active
			@lobbyists = Lobbyist.joins(:lobbyist_registrations).where('lobbyist_registrations.is_active = 1')
		elsif @show_inactive
			@lobbyists = Lobbyist.joins(:lobbyist_registrations).where('lobbyist_registrations.is_active = 0')
		else 
			@lobbyists = Lobbyist.joins(:lobbyist_registrations).where('lobbyist_registrations.is_active = 1')
		end

		if @state and @state != '0' and @lobbyists.count > 0
			@lobbyists = @lobbyists.where(:state => @state)
		end

		@years = LobbyistRegistration.pluck(:year_registered).sort().uniq
                

		if not @year
			@year = 0
			@years.each do |y|
				if y.to_i > @year.to_i
					@year = y
				end
		        end
		end

		if @year and @year != '0' and @lobbyists.count > 0
			@lobbyists = @lobbyists.where('lobbyist_registrations.year_registered = ?', @year)
		end
	
		if @last_name and @last_name != '0' and @lobbyists.count > 0
			@lobbyists = @lobbyists.where(:last_name => @last_name)
		end

		@lobbyist_count = Lobbyist.where(:active => 1 ).count()
		@client_count = Client.includes(:lobbyist_clients).where('lobbyist_client.is_active = 1').count()

		@states = Lobbyist.pluck(:state).sort().uniq
		
		@last_names = Lobbyist.pluck(:last_name).sort().uniq


		@most_viewed_lobbyist = PageView.joins(:lobbyist).select('lobbyist_id,count(*) as page_views' ).where('page_views.lobbyist_id is not null').group('page_views.lobbyist_id').order('count(*) desc').first

		@lobbyists = @lobbyists.paginate(:page => params[:page], :per_page => 50)

		@title = 'Alabama Lobbyists'

		add_breadcrumb "Lobbyists", ""
	end
end
