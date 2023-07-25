module StripeServices
  class DowngradeService < SubscriptionService
    attr_reader :subscription_id, :product_name

    def initialize(subscription_id, product_name)
      @subscription_id = subscription_id
      @product_name = product_name
    end

    def call
      change_subscription
    end
  end
end