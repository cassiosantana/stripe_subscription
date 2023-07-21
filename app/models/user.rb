class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def subscribed?
    subscription_id? || expires_at
  end

  def unsubscribe(subscription)
    expires_at = Time.at(subscription.current_period_end)
    update(subscription_id: nil, expires_at: expires_at)
  end
end
