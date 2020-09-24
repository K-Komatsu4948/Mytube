class ToppagesController < ApplicationController
  before_action :require_user_logged_in, only: [:index]
require 'google/apis/youtube_v3'
require 'active_support/all'

GOOGLE_API_KEY = ENV['KEY']
def index
  @params  = result_params
  @youtube_data = find_videos(@params)
end

  def find_videos(keyword, after: 1.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY

    next_page_token = nil
    opt = {
      q: :keyword,
      type: 'video',
      max_results: 1,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    @youtube_data = service.list_searches(:snippet, opt)
  end
  def result_params
    params.permit(:content)
  end
end