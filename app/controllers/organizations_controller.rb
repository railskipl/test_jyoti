class OrganizationsController < ApplicationController
	respond_to :html, :js
  
 def index
 	 @organizations = Organization.all
 end


  def new
    @organization = Organization.new
   
  end
  
  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
     redirect_to org2_organizations_path
    else
      render 'new'
    end
  end

 def status
  @organization = Organization.find(params[:id])
  @organization.status = !@organization.status?
    @organization.save!
    redirect_to :back 
 end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
       redirect_to organizations_path
    else
      render 'edit'
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to organizations_path
  end

  def org2
    
  end

end
