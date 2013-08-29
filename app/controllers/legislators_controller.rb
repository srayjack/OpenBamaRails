class LegislatorsController < ApplicationController

	def index
		@chambers = params[:chambers]
		@parties = params[:parties]

		@district = params[:district]

		@chamber_house = false
		@chamber_senate = false

		@party_republican = false
		@party_democrat = false
		@party_other = false

		@districts = Person.unscoped.where(:isActive => 1).select('distinct cast(district as signed) as district').order('1')

		if @chambers

			@chambers.each do |c|
				if c == 'house'
					@chamber_house = true
				elsif c == 'senate'
					@chamber_senate = true
				end
			
			end
		else
			@chamber_house = true
			@chamber_senate = true
		end


		if @chamber_house and @chamber_senate
			@legislators = Person.where(:isActive => 1)

		elsif @chamber_senate
			@legislators = Person.where(:isActive => 1).where(:title => 'Sen.')
		elsif @chamber_house
			@legislators = Person.where(:isActive => 1).where(:title => 'Rep.')
		else 
			@legislators = Person.where(:isActive => 1)
		end
		
		if @parties

			@parties.each do |p|
				if p == 'republican'
					@party_republican = true
				end
				if p == 'democrat'
					@party_democrat = true
				end
				if p == 'other'
					@party_other = true
				end
			
			end
		else
			@party_republican = true
			@party_democrat = true
			@party_other = true
		end

		if not (@party_republican and @party_democrat and @party_other)
			
			if not @party_republican
				@legislators = @legislators.where("people.party <> 'republican'")
			end
			if not @party_democrat
				@legislators = @legislators.where("people.party <> 'democrat'")
			end
			if  not @party_other
				@legislators = @legislators.where("people.party = 'republican' or people.party = 'democrat'")
			end
		end

		if @district 
			@legislators = @legislators.where(:district => @district)
		end

		@legislators = @legislators.paginate(:page => params[:page], :per_page => 25)

		@base_image_url = AppConfiguration.where(:name => 'base_image_url').first.value

		@title = 'List of All Legislators'

		add_breadcrumb "Legislators", ""

	end
end
