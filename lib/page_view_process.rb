class PageViewProcess

	def self.get_correct_property(object_name)
		if object_name == 'bill'
			return :bill_id
		elsif object_name == 'person'
			return :person_id
		elsif object_name == 'blog_post'
			return :blog_post_id
		elsif object_name == 'client'
			return :client_id
		elsif object_name == 'committee'
			return :committee_id
		elsif object_name == 'lobbyist'
			return :lobbyist_id

		elsif object_name == 'roll_call'
			return :roll_calls_id
			
		end
	end


	def self.process_page_view(object_name, object_id, visitor_id, user_agent)
		#@visitor_id = cookies[:visitor]
		if not visitor_id
			visitor = Visitor.new(:date_visited => Date.today)
			visitor.save
			visitor_id = visitor.id
			#cookies[:visitor] = @visitor_id
		end

		if not BotSniffer.smells_like_a_bot?(user_agent)

			page_view = PageView.where(get_correct_property(object_name) => object_id).where(:visitors_id => visitor_id).first

			if not page_view
				page_view = PageView.new(:ip => ' ',get_correct_property(object_name) => object_id, :visitors_id => visitor_id, :viewed_on => Date.today)
				page_view.save
				
			else

				page_view.viewed_on = Date.today
				page_view.save
			end
		end

		return visitor_id
	end

end