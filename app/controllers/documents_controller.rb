class DocumentsController < ApplicationController
	def new
		@project = Project.find_by_id(params[:project_id])
		@document = @project.documents.build
	end

	def create
		@document = Document.new(params_document)
		@document.project_id = params[:project_id]
		if @document.save
			flash[:notice] = "Document was added!"
			redirect_to project_url(@document.project_id)
		else
			render 'project/show'
		end
	end

	def edit
		@document = Document.find_by_id(params[:id])
		@project = Project.find_by_id(params[:project_id])
	end

	def update
		@document = Document.find_by_id(params[:id])
		@document.update_attributes(params_document)
		redirect_to project_url(@document.project_id)
	end

	def destroy
		@document = Document.find_by_id(params[:id])
		@document.destroy
		redirect_to project_url(@document.project_id)
	end

  private
	def params_document
		params.require(:document).permit(:title, :body, :project_id, :attachment)
	end
end
