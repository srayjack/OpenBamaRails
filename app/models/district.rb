class District < ActiveRecord::Base
  set_inheritance_column :ruby_type

  # getter for the "type" column
  def chamber_type
    self[:type]
  end

  # setter for the "type" column
  def chamber_type=(s)
    self[:type] = s
  end

end
