module Subscriptions
  class DowngradesController < ApplicationController
    def update
      success = StripeServices::DowngradeService.call(current_user.subscription.stripe_id, params[:product_name])

      if success
        flash.notice = "You have upgraded your subscription."
      else
        flash.alert = "There was a problem upgrading your subscription."
      end

      redirect_to root_path
    end
  end
end