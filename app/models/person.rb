class Person < ActiveRecord::Base

  has_one	:person_meta
  has_many	:addresses
  has_many	:web_addresses
  has_many	:bills, :foreign_key => 'sponsor_id'
  has_many	:bill_cosponsors
  has_many	:bills, :through => :bill_cosponsors
  has_many	:committees, :through => :committee_people
  has_many	:page_views, :foreign_key => 'person_id'
  default_scope	:order => 'title, lastname, firstname'
 
  
  def district_description
	if title == 'Sen.'
		@chamber = 's'
	elsif title == 'Rep.'
		@chamber = 'h'
	end
	
	@dist = District.where(:type => @chamber).where(:district_number => district).first
	if @dist
		@dist.description
	else
		'No description'
	end
	
  end
end
