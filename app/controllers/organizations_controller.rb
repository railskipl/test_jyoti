class OrganizationsController < ApplicationController
	respond_to :html, :js
  require 'will_paginate/array'
  
 def index
 	 @organizations = Organization.all

 end

 def import_csv
    @contacts = Contact.where("user_id = ? " ,current_user.id).paginate :page => params[:page],:per_page => 10
 end

  def new
  @contacts = Contact.where("user_id = ? " ,current_user.id)
  @organization = Organization.new
   
  end


  
  
  def create
    @organization = Organization.new(params[:organization])
    @organization = Organization.new
    @contacts = Contact.new
    
    @contacts = Contact.all
    if @contacts.count >= 5
    if @organization.save   
     redirect_to org2_organizations_path
    else
       render 'org2'
    end
    else
      redirect_to new_organization_path, notice: "Please upload atleast 5 users." 
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
