class SearchController < ApplicationController
  before_action :authenticate_user!

  def users
    distance = params[:distance] == 'All' ? '' : params[:distance]
    @users = User.search_by_distance(current_user, distance)
                 .search_by_interest(params[:interest])
                 .search_by_skill(params[:skill]) 
  end

  def organizations
    distance = params[:distance] == 'All' ? '' : params[:distance]
    @organizations = Organization.search_by_distance(current_user, distance)
                                 # .search_by_interest(params[:interest])
                                 # .search_by_skill(params[:skill])
    gmaps_hash
  end

  def gmaps_hash
    @hash = Gmaps4rails.build_markers(@organizations) do |organization, marker|
        marker.lat organization.latitude
        marker.lng organization.longitude
        marker.infowindow "#{organization.street}, #{organization.city}, #{organization.state}"
    end   
  end
end
