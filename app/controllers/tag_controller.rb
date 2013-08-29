class TagController < ApplicationController

	def index
		@id = params[:id]
		@current_session = AppConfiguration.where(:name => 'current_session').first
		@bills = Bill.where(:session_identifier => @current_session.value).joins(:bill_tags).where('bills_tags.tag_id' => @id)
		@tags = Tag.all
		@tag = Tag.find(@id)
		@title = 'Bills for Tag ' + @tag.tag_name
	end 
end
