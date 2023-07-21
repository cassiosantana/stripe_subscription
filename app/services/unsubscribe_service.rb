class UnsubscribeService
  def self.call(user)
    new(user).call
  end

  def initialize(user)
    @user = user
  end

  def call
    subscription = find_subscription

    return false unless subscription

    updated_subscription = update_subscription(subscription)
    user.unsubscribe(updated_subscription) if updated_subscription
  end

  private

  def find_subscription
    Stripe::Subscription.retrieve(@user.subscription_id)
  end

  def update_subscription(subscription)
    Stripe::Subscription.update(
      subscription.id,
      cancel_at_period_end: true
    )
  end
end