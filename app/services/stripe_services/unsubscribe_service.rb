module StripeServices
  class UnsubscribeService < SubscriptionService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      subscription_id = user.subscription.stripe_id

      return false unless subscription_id

      updated_subscription = update_subscription(subscription_id, true)
      user.subscription.update(active: false) if updated_subscription
    end
  end
end