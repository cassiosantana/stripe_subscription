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

    # Currently, this method performs subscription plan swapping,
    # and both the upgrade and downgrade controllers use this method
    # because the rule for plan changes remains the same. For didactic
    # purposes, the structure of having a separate controller for each
    # action is maintained. If the rule changes in the future, only the
    # method needs to be altered according to the new requirement.
    def change_subscription
      ::Stripe::Subscription.update(
        subscription_id,
        proration_behavior: 'create_prorations',
        items: [
          {
            id: item_id,
            price: price_id
          }
        ]
      )
    end

    def price_id
      ::Stripe::Price.list(product: product_name).data.first&.id
    end

    def item_id
      find_subscription_by_id(subscription_id).items.data.first.id
    end
  end
end