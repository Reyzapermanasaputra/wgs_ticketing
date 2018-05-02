class CredentialsController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.find_by_id(params[:project_id])
    if @project.credential.nil?
      @credential = @project.build_credential
      @check_credential = true
    else
      @credential = @project.credential
      @check_credential = false
    end
  end

  def create
    @credential = Credential.new(params_credential)
    @credential.project_id = params[:project_id]
    if @credential.save
      flash[:notice] = "Credential was added!"
      redirect_to project_credentials_path(params[:project_id])
    else
      flash[:notice] = @credential.errors.full_messages.map{|k,v| k}.join("<br/>").html_safe
      @project = Project.find_by_id(params[:project_id])
      render 'projects/credential/_credential_form'
    end
  end

  def show
    @project = Project.find_by_id(params[:project_id])
    if @project.credential.nil?
      @credential = @project.build_credential
      @check_credential = true
    else
      @credential = @project.credential
      @check_credential = false
    end
  end

  def edit
    @credential = Credential.find_by_id(params[:id])
    @project = Project.find_by_id(params[:project_id])
  end

  def update
    @credential = Credential.find_by_id(params[:id])
    @credential.update_attributes(params_credential)
    if @credential.errors.present?
      flash[:notice] = @credential.errors.full_messages.map{|k,v| k}.join("<br/>").html_safe
      @project = Project.find_by_id(params[:project_id])
      render action: "edit"
    else
      flash[:notice] = "Credential was updated!"
      redirect_to project_credential_path(params[:project_id])
    end
  end

  private
  def params_credential
    params.require(:credential).permit(:title, :body, :project_id)
  end
end
