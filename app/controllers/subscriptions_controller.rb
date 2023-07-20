class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      client_reference_id: current_user.id,
      customer_email: current_user.email,
      subscription_data: {
        items: [{
                  plan: "premium"
                }]
      },
      success_url: "http://localhost:3000",
      cancel_url: "http://localhost:3000"
    )
    @session_id = session.id
  end
end
