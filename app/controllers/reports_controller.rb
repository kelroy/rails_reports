class ReportsController < ApplicationController
  
  def index
  end
  
  def '/range?' 
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    
    puts @start_date
    puts @end_date
  end

end
