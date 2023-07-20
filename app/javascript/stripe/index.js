document.addEventListener('turbo:load', function() {
  const div = document.getElementById('payment')
  if (div === null) { return }

  const stripe_public_key = document.querySelector('meta[name="stripe-public-key"]').getAttribute('content');
  const stripe = Stripe(stripe_public_key)
  stripe.redirectToCheckout({
    sessionId: div.getAttribute('data-session-id')
  }).then(function (results) {

  })
})