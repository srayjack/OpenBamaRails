class PersonRating < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :rating, :person_id, :created_on, :updated_on, :visitors_id
  set_table_name 'person_ratings'  
  belongs_to	:person
end
