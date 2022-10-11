class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index 
    @work_orders = WorkOrder.all  
  end
end