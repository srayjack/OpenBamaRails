class SubjectController < ApplicationController
  def index
	@id = params[:id]
	@current_session = AppConfiguration.where(:name => 'current_session').first
	@bills = Bill.where(:session_identifier => @current_session.value).joins(:bill_subjects).where('bills_subjects.subject_id' => @id)
	@subject = Subject.find(@id)
	@subjects = Subject.all
	add_breadcrumb "Issues/Subjects", "/subjects"
	add_breadcrumb @subject.subject, request.fullpath
	@title = 'Bills for Subject ' + @subject.subject
  end
end
