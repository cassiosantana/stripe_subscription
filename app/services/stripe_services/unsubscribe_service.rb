module StripeServices
  class UnsubscribeService < SubscriptionService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      subscription = find_subscription_by_id(user.subscription_id)

      return false unless subscription

      updated_subscription = update_subscription(subscription, true)
      user.unsubscribe(updated_subscription) if updated_subscription
    end
  end
end