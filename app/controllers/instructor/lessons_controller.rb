class Instructor::LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_section


def new # note direct use of helper method calls vs. variable for current section
    # if current_section.course.user != current_user
    #   return render :text => 'Unauthorized', :status => :unauthorized
    # end
    @lesson = Lesson.new
end

def create
    # if current_section.course.user != current_user
    #   return render :text => 'Unauthorized', :status => :unauthorized
    # end
    @lesson = current_section.lessons.create(lesson_params)
    redirect_to instructor_course_path(current_section.course)
end

private

def require_authorized_for_current_section
	if current_section.course.user != current_user
		return render :text => 'Unauthorized', :status => :unauthorized
	end
end

  helper_method :current_section  #allows view to call this and directly use current_section
  def current_section
  	@current_section ||= Section.find(params[:section_id])
  end

  def lesson_params
  	params.require(:lesson).permit(:title, :subtitle, :video)
  end
end
