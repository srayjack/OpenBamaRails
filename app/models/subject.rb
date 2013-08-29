class Subject < ActiveRecord::Base
  # attr_accessible :title, :body
	default_scope :conditions => ['subject is not null'], :order => 'subject'
	has_many :bill_subjects
	has_many :bills, :through => :bill_subjects
end
