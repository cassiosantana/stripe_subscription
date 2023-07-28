module StripeServices
  class CustomerService < BaseService
    attr_reader :event, :user, :customer_id, :balance

    def initialize(event)
      @event = event
      @user = find_user_from_event
      @customer_id = event_customer_id
      @balance = customer_balance
    end

    def call
      customer_record = Customer.find_by(user_id: user.id, stripe_id: customer_id)

      if customer_record.nil?
        Customer.create(user_id: user.id, stripe_id: customer_id, balance: balance)
      elsif customer_record.balance != balance
        customer_record.update(balance: balance)
      end
    end

    private
    def customer_balance
      @balance ||= ::Stripe::Customer.retrieve(customer_id).balance
    end

    def find_user_from_event
      User.find_by(id: event.data.object.client_reference_id)
    end

    def event_customer_id
      event.data.object.customer
    end
  end
end