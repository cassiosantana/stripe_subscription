class HomeController < ApplicationController
  def index
    if current_user&.subscription.active
      subscription = ::Stripe::Subscription.retrieve(current_user.subscription.stripe_id)
      @subscription_plan = subscription.plan.product.capitalize
    end
  end
end
