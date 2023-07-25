module StripeServices
  class UpgradeService < SubscriptionService
    attr_reader :subscription_id, :product_name

    def initialize(subscription_id, product_name)
      @subscription_id = subscription_id
      @product_name = product_name
    end

    def call
      upgrade_subscription
    end

    private

    def upgrade_subscription
      subscription = find_subscription_by_id(subscription_id)
      new_price_id = find_price_id_by_product_name(product_name)

      ::Stripe::Subscription.update(
        subscription.id,
        proration_behavior: 'create_prorations',
        items: [
          {
            id: subscription.items.data.first.id,
            price: new_price_id
          }
        ]
      )
    end

    def find_price_id_by_product_name(product_name)
      prices = Stripe::Price.list(product: product_name)
      prices.data.first&.id
    end
  end
end