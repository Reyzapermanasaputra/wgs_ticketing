class CredentialsController < ApplicationController
  before_action :authenticate_user!

  def create
    @credential = Credential.new(params_credential)
    @credential.project_id = params[:project_id]
    if @credential.save
      redirect_back(fallback_location: root_path)
    else
      render 'project/show'
    end
  end

  def edit
    @credential = Credential.find_by_id(params[:id])
    @project = Project.find_by_id(params[:project_id])
  end

  def update
    @credential = Credential.find_by_id(params[:id])
    @credential.update_attributes(params_credential)
    redirect_to project_url(@credential.project_id)
  end

  private
  def params_credential
    params.require(:credential).permit(:title, :body, :project_id)
  end
end
