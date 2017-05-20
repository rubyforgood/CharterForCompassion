class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :edit, :update]

  def index
    @organizations = current_user.organizations.all
  end

  def show
  end

  def new
    @organization = current_user.organizations.new
  end

  def create
    @organization = current_user.organizations.build(organization_params)

    if @organization.save
      flash[:success] = 'Organization saved successfully'
      redirect_to organization_path(@organization)
    else
      flash.now[:error] = 'Unable to save organization'
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      flash[:success] = 'Organization updated successfully'
      redirect_to organization_path(@organization)
    else
      flash.now[:error] = 'Unable to update organization'
      render :edit
    end
  end

  private
  def organization_params
    params.require(:organization).permit(:name, :address, :description, :city,
      :state, :zipcode)
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end
