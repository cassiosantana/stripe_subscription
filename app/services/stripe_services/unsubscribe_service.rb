module StripeServices
  class UnsubscribeService < SubscriptionService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      subscription = find_subscription_by_id(user.subscription.subscription_id)

      return false unless subscription

      updated_subscription = update_subscription(subscription, true)
      user.subscription.update(active: false) if updated_subscription
    end
  end
end