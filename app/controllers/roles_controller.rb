class RolesController < ApplicationController
  
  def index
  	@roles = Role.all
  	@role = Role.new
  end

  def create
  	@role = Role.new(params_role)
  	if @role.save
  		flash[:notice] = "Role telah ditambahkan!"
  	else
  		flash[:error] = "Terjadi Kesalahan!"
  	end
  end

  def destroy
    @role = Role.find_by_id(params[:id])
    @role.destroy
  end

  def new
  end

  def edit
  end

  private

  def params_role
  	params.require(:role).permit(:name, :is_active)
  end
end
