class PagesController < ApplicationController

respond_to :html, :js
  

 def index
 	 @pages = Page.all
 end


  def new
    @page = Page.new
   
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
     redirect_to pages_path
    else
      render 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
       redirect_to pages_path
    else
      render 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to pages_path
  end
  

end
