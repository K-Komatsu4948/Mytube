class ResultsController < ApplicationController
  before_action :require_user_logged_in
  def index
    @results = @result_data
    
    @results = current_user.results.order(id: :desc).page(params[:page]).per(5)
  end
end
