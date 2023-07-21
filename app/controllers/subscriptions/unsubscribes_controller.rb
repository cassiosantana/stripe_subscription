module Subscriptions
  class UnsubscribesController < ApplicationController
    def destroy
      subscription = Stripe::Subscription.update(current_user.subscription_id, { cancel_at_period_end: true })
      expires_at = Time.at(subscription.current_period_end)
      current_user.update(subscription_id: nil, expires_at: expires_at)
      redirect_to root_path, notice: "You have cancelled your subscription.
      You will have access until #{l current_user.expires_at.to_date, format: :long}."
    end
  end
end