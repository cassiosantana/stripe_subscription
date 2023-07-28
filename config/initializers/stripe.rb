Stripe.api_key = ENV['STRIPE_API_KEY']

StripeEvent.signing_secret = ENV['STRIPE_WEBHOOK_KEY']

StripeEvent.configure do |config|
  config.subscribe 'checkout.session.completed' do |event|
    begin
      StripeServices::SubscribeService.call(event)
      StripeServices::CustomerService.call(event)
    rescue StandardError => e
      Rails.logger.error("Error processing checkout.session.completed event: #{e.message}")
    end
  end

  config.subscribe 'customer.subscription.deleted' do |event|
    begin
      Subscription.destroy_by(stripe_id: event.data.object.id)
      Customer.destroy_by(stripe_id: event.data.object.customer)
    rescue StandardError => e
      Rails.logger.error("Error processing checkout.session.completed event: #{e.message}")
    end
  end
end
