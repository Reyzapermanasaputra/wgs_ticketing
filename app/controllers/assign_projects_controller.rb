class AssignProjectsController < ApplicationController
  def index
  	@projects = Project.all
  end
end
