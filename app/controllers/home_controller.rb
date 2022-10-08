class HomeController < ApplicationController
  def index
    @work_orders = WorkOrder.all
  end
  def edit
    
  end
end