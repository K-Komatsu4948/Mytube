class ToppagesController < ApplicationController
  before_action :require_user_logged_in
require 'google/apis/youtube_v3'
require 'active_support/all'

GOOGLE_API_KEY = ENV['KEY']
  def index
    @data = find_videos(params[:content])
    if @data
      flash[:success] = '検索に成功しました。'
    else
      flash.now[:danger] = '検索上限を超えたため失敗しました。'
      render :login
    end
    
    @result_data = current_user.results.find_or_create_by(content: params[:content])
    if @result_data
      render:index
    else
      render :index
    end
  end

  def find_videos(keyword, after: 1.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 1,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    service.list_searches(:snippet, opt)
    
  end
end