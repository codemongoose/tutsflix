class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_course, :only => [:show]

	def show
	end

	private

	def require_authorized_for_current_course	
     # There needs to be better way to minimize the dB hits - load hash ; use sessions obj etc ?
     # @section_id = current_lesson.section_id
     # @course_id = Section.find(@section_id).course_id
     # @course = Course.find(@course_id)

     @course = Course.find(Section.find(current_lesson.section_id).course_id)

     if ! (current_user && current_user.enrolled_in?(@course)) 
     	redirect_to course_path(@course), :alert => 'You are not Authorized to the lesson'	
     end
 end


 helper_method :current_lesson
 def current_lesson
 	@current_lesson ||= Lesson.find(params[:id])
 end



end







