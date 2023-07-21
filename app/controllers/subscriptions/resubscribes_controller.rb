module Subscriptions
  class ResubscribesController < ApplicationController
    def new
      updated_subscription = ResubscribeService.call(current_user)

      if updated_subscription
        current_user.update(subscription_id: updated_subscription.id, expires_at: nil)
        flash.notice = "Thanks for resubscribing!"
      else
        flash.alert = "There was a problem resubscribing!"
      end

      redirect_to root_path
    end
  end
end