module StripeServices
  class SubscribeService < BaseService
    attr_reader :event, :user, :subscription

    def initialize(event)
      @event = event.data.object
      @user = find_user
      @subscription = retrieve_subscription
    end

    def call
      subscription_record = Subscription.find_by(user_id: user.id, stripe_id: subscription.id)

      if subscription_record
        update_subscription(subscription_record)
      else
        create_subscription
      end
    end

    private

    def update_subscription(subscription_record)
      subscription_record.update(
        current_period_end: Time.at(subscription.current_period_end),
        current_period_start: Time.at(subscription.current_period_start),
        active: true
      )
    end

    def create_subscription
      Subscription.create(
        user_id: user.id,
        stripe_id: subscription.id,
        current_period_end: Time.at(subscription.current_period_end),
        current_period_start: Time.at(subscription.current_period_start),
        active: true
      )
    end

    def find_user
      User.find_by(id: event.client_reference_id)
    end

    def retrieve_subscription
      Stripe::Subscription.retrieve(event.subscription)
    end
  end
end
