class HomeController < ApplicationController
  def index
    if current_user&.subscription.subscription_id
      @subscription_id = current_user.subscription.subscription_id
    end
  end
end
