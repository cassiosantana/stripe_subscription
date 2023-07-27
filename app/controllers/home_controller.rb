class HomeController < ApplicationController
  def index
    if current_user&.subscription_id
      subscription = ::Stripe::Subscription.retrieve(current_user.subscription_id)
      @subscription_plan = subscription.plan.product.capitalize
    end
  end
end
