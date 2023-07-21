module StripeServices
  class SubscriptionService < BaseService
    private

    def find_subscription_by_customer(customer_id)
      ::Stripe::Subscription.list(customer: customer_id).first
    end

    def find_subscription_by_id(subscription_id)
      ::Stripe::Subscription.retrieve(subscription_id)
    end

    def update_subscription(subscription, cancel_at_period_end)
      ::Stripe::Subscription.update(
        subscription.id,
        cancel_at_period_end: cancel_at_period_end
      )
    end
  end
end