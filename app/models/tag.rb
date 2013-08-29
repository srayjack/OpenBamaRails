class Tag < ActiveRecord::Base
#  has_many :bill_tags
  #has_many :bills, :through => :bill_tags
  attr_accessible :tag_name
  default_scope :order => 'tag_name'
end
