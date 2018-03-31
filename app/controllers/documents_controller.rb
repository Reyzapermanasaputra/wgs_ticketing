class DocumentsController < ApplicationController
	def new
		@project = Project.find_by_id(params[:project_id])
		@document = @project.documents.build
	end

	def create
		
	end

  private
	def params_document
		params.require(:document).permit(:title, :body, :project_id)
	end
end
