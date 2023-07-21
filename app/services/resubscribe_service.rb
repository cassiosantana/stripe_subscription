class ResubscribeService
  def self.call(user)
    new(user).call
  end

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    subscription = find_subscription

    return false unless subscription

    updated_subscription = update_subscription(subscription)
    user.resubscribe(updated_subscription) if updated_subscription
  end

  private

  def find_subscription
    Stripe::Subscription.list(customer: user.stripe_id).first
  end

  def update_subscription(subscription)
    Stripe::Subscription.update(
      subscription.id,
      cancel_at_period_end: false
    )
  end
end
