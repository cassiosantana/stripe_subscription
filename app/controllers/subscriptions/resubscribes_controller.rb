module Subscriptions
  class ResubscribesController < ApplicationController
    def new
      success = StripeServices::ResubscribeService.call(current_user)

      if success
        flash.notice = "Thanks for resubscribing!"
      else
        flash.alert = "There was a problem resubscribing!"
      end

      redirect_to root_path
    end
  end
end