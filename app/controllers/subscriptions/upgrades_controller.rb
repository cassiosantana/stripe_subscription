module Subscriptions
  class UpgradesController < ApplicationController

    def update

      success = StripeServices::UpgradeService.upgrade_subscription(current_user.subscription_id, params[:plan_name])

      if success
        flash.notice = "You have upgraded your subscription."
      else
        flash.alert = "There was a problem upgrading your subscription."
      end

      redirect_to root_path
    end
  end
end