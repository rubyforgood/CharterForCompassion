class SearchController < ApplicationController
  before_action :authenticate_user!

  def users
    distance = params[:distance] == 'All' ? '' : params[:distance]
    @users = User.search_by_interest(params[:interest])
                 .search_by_skill(params[:skill])
                 .search_by_distance(current_user, distance)
  end
end
