class IndividualsController < ApplicationController
	respond_to :html, :js
  
 def index
 	 @individuals = Individual.all
 end


  def new
    @individual = Individual.new
   
  end
  
  def create
    @individual = Individual.new(params[:individual])
    if @individual.save
     redirect_to individuals_path
    else
      render 'new'
    end
  end

 def status
  @individual = Individual.find(params[:id])
  @individual.status = !@individual.status?
    @individual.save!
    redirect_to :back 
 end

  def edit
    @individual = Individual.find(params[:id])
  end

  def update
    @individual = Individual.find(params[:id])
    if @individual.update_attributes(params[:Individual])
       redirect_to individuals_path
    else
      render 'edit'
    end
  end

  def destroy
    @individual = Individual.find(params[:id])
    @individual.destroy
    redirect_to individuals_path
  end
end
