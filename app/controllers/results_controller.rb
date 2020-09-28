class ResultsController < ApplicationController
  before_action :require_user_logged_in
  def index
    @results = @result_data
    
    @results = Result.order(id: :desc).page(params[:page]).per(5)
  end
end
