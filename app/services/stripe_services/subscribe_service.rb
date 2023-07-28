module StripeServices
  class SubscribeService < BaseService
    attr_reader :event, :user, :subscription

    def initialize(event)
      @event = event.data.object
      @user = find_user
      @subscription = retrieve_subscription
    end

    def call
      subscription_record = find_or_create_subscription_record

      update_subscription_record(subscription_record)
    end

    private

    def find_or_create_subscription_record
      Subscription.find_or_create_by(user_id: user.id, stripe_id: subscription.id) do |new_subscription|
        new_subscription.current_period_end = Time.at(subscription.current_period_end)
        new_subscription.current_period_start = Time.at(subscription.current_period_start)
        new_subscription.active = true
      end
    end

    def update_subscription_record(subscription_record)
      update_attributes = {
        current_period_end: Time.at(subscription.current_period_end),
        current_period_start: Time.at(subscription.current_period_start),
        active: true
      }.reject { |key, value| subscription_record[key] == value }

      subscription_record.update(update_attributes) if update_attributes.present?
    end

    def find_user
      User.find_by(id: event.client_reference_id)
    end

    def retrieve_subscription
      Stripe::Subscription.retrieve(event.subscription)
    end
  end
end
