class SubscribeService
  def self.call(event)
    new(event).call
  end

  attr_reader :event

  def initialize(event)
    @event = event
  end

  def call
    # TODO
  end
end