class SubscribeService
  def self.call(event)
    new(event).call
  end

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def call
    user = User.find_by(id: object.client_reference_id)
    return unless user

    user.update(stripe_id: object.customer, subscription_id: object.subscription)
  end

  private

  def object
    @object ||= event.data.object
  end
end