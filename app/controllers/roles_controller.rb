class RolesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
  	@roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
  	@role = Role.new(create_params)
  	if @role.save
  		flash[:notice] = "Role was added!"
      redirect_to action: "index"
  	else
  		flash[:error] = @role.errors.full_messages.map { |k,v| k }.join('<br>').html_safe
      render action: 'new'
  	end
  end

  def edit
    @role = Role.find_by_id(params[:id])
  end

  def update
    @role = Role.find_by_id(params[:id])
    @role.update_attributes(create_params)
    if @role.errors.present?
      flash[:notice] = @role.errors.full_messages.map { |k,v| k }.join('<br>').html_safe
      render action: "edit"
    else
      flash[:notice] = "Role was updated"
      redirect_to action: "index"
    end
  end

  def destroy
    @role = Role.find_by_id(params[:id])
    @role.destroy
    flash[:notice] = "Role was deleted"
    redirect_to action: "index"
  end


  private

  def create_params
  	params.require(:role).permit(:name, :code, :is_active)
  end
end
