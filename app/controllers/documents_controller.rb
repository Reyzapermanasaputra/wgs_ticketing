class DocumentsController < ApplicationController
	before_action :authenticate_user!
	def new
		@project = Project.find_by_id(params[:project_id])
		@document = @project.documents.build
	end

	def create
		@document = Document.new(params_document)
		@document.project_id = params[:project_id]
		if @document.save
			flash[:notice] = "Document was added!"
			redirect_to project_documents_path(@document.project_id)
		else
			@project = Project.find_by_id(params[:project_id])
			flash[:error] = @document.errors.full_messages.map { |k, v| k}.join('<br>').html_safe
			render action: 'new'
		end
	end

	def edit
		@document = Document.find_by_id(params[:id])
		@project = Project.find_by_id(params[:project_id])
	end

	def update
		@document = Document.find_by_id(params[:id])
		@document.update_attributes(params_document)
		if @document.errors.present?
			@project = Project.find_by_id(params[:project_id])
			flash[:notice] = @document.errors.full_messages.map {|k,v| k }.join("<br/>").html_safe
			render action: "edit"
		else
			flash[:notice] = "Document was edited"
			redirect_to project_documents_path(@document.project_id)
	  end
	end

	def destroy
		@document = Document.find_by_id(params[:id])
		@document.destroy
		redirect_to project_documents_path(@document.project_id)
	end

  private
	def params_document
		params.require(:document).permit(:title, :body, :project_id, :attachment)
	end
end
