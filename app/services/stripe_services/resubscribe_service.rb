module StripeServices
  class ResubscribeService < SubscriptionService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      subscription_id = user.subscription.stripe_id

      return false unless subscription_id

      updated_subscription = update_subscription(subscription_id, false)
      user.subscription.update(active: true) if updated_subscription
    end
  end
end