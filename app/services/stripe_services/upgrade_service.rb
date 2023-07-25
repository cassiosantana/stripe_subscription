module StripeServices
  class UpgradeService

    def self.upgrade_subscription(subscription_param, product)
      subscription = find_subscription_by_id(subscription_param)
      upgrade_product = find_subscription_by_product(product)

      ::Stripe::Subscription.update(
        subscription.id,
        proration_behavior: 'create_prorations',
        items: [
          {
            id: subscription.items.data.first.id,
            price: Stripe::Price.list(product: product).data.first&.id
          }
        ]
      )
    end

    def self.find_subscription_by_id(subscription_id)
      ::Stripe::Subscription.retrieve(subscription_id)
    end

    def self.find_subscription_by_product(product)
      ::Stripe::Product.retrieve(product)
    end
  end
end