class BlogPost < ActiveRecord::Base
	default_scope :order => 'created_at desc'

	def post_url
		return "/blog/" + self.created_at.strftime('%Y') + "/" +  self.created_at.strftime('%m') + "/" + self.slug
	end
end
