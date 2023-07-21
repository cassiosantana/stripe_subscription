module Subscriptions
  class UnsubscribesController < ApplicationController
    def destroy
      success = StripeServices::UnsubscribeService.call(current_user)

      if success
        flash.notice = "You have cancelled your subscription. You will have access until
          #{l current_user.expires_at.to_date, format: :long}."
      else
        flash.alert = "There was a problem cancelling your subscription."
      end

      redirect_to root_path
    end
  end
end