class SearchController < ApplicationController
  before_action :authenticate_user!

  def users
    distance = params[:distance] == 'All' ? '' : params[:distance]
    @users = User.search_by_distance(current_user, distance)
                 .search_by_interest(params[:interest])
                 .search_by_skill(params[:skill])
    gmaps_hash   
  end

  def organizations
    distance = params[:distance] == 'All' ? '' : params[:distance]
    @organizations = Organization.search_by_distance(current_user, distance)
                                 # .search_by_interest(params[:interest])
                                 # .search_by_skill(params[:skill])
  end

  def gmaps_hash
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.infowindow user.address
        marker.infowindow user.city
        marker.infowindow user.state
    end   
  end
end
