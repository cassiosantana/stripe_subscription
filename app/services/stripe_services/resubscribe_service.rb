module StripeServices
  class ResubscribeService < SubscriptionService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      subscription = find_subscription_by_customer(user.stripe_id)

      return false unless subscription

      updated_subscription = update_subscription(subscription, false)
      user.subscription.update(active: true) if updated_subscription
    end
  end
end