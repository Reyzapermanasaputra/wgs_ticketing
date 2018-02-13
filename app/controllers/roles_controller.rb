class RolesController < ApplicationController
  before_action :authenticate_user!
  def index
  	@roles = Role.all
  end

  def new
    @role = Role.new
  end

  def create
  	@role = Role.new(params_role)
  	if @role.save
  		flash[:notice] = "Role telah ditambahkan!"
      redirect_to action: "index"
  	else
  		flash[:error] = "Terjadi Kesalahan!"
      render action: 'new'
  	end
  end

  def edit
    @role = Role.find_by_id(params[:id])
  end

  def update
    @role = Role.find_by_id(params[:id])
    @role.update_attributes(params_role)
    redirect_to action: "index"
  end

  def destroy
    @role = Role.find_by_id(params[:id])
    @role.destroy
  end


  private

  def params_role
  	params.require(:role).permit(:name, :is_active)
  end
end
