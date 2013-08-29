class PageView < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'page_views'
  attr_accessible :bill_id
  attr_accessible :visitors_id
  attr_accessible :viewed_on
  attr_accessible :ip
  attr_accessible :roll_calls_id
  attr_accessible :person_id
  attr_accessible :committee_id
  attr_accessible :client_id
  attr_accessible :lobbyist_id
  attr_accessible :blog_post_id

  belongs_to :bill, :foreign_key => 'bill_id'
  belongs_to :person, :foreign_key => 'person_id'
  belongs_to :lobbyist, :foreign_key => 'lobbyist_id'
  belongs_to :client, :foreign_key => 'client_id'
  belongs_to :blog_post, :foreign_key => 'blog_post_id'

end
