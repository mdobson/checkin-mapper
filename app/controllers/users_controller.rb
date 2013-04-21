class UsersController < ApplicationController
  def new
    render text: "<a href='#{new_foursquare_client_path}'><img src='https://playfoursquare.s3.amazonaws.com/press/logo/connect-black.png' /></a>"
  end

  def show
    filtered_checkins = []
    current_user.checkins["items"].each do |checkin|
      filtered_checkin = {}
      filtered_checkin["location"] = {}
      filtered_checkin["location"]["lat"] = checkin["venue"]["location"]["lat"]
      filtered_checkin["location"]["lng"] = checkin["venue"]["location"]["lng"]
      filtered_checkin["name"] = checkin["venue"]["name"]
      filtered_checkins.push(filtered_checkin)
    end
    render json: "#{filtered_checkins.to_json}"
  end

  private
  def current_user
    @current_user ||= FoursquareUser.find(session[:user_id])
  end
end