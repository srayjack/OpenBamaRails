class CommitteePerson < ActiveRecord::Base
  set_table_name 'committees_people'
  belongs_to :person
  belongs_to :committee

  def role_rank
	return CommitteeRoleRank.where(:role => role).first.rank

  end

end
