require 'sinatra'
require 'stripe'
require 'dotenv'
require 'json'
require 'encrypted_cookie'

Dotenv.load
Stripe.api_key = ENV['STRIPE_TEST_SECRET_KEY']

use Rack::Session::EncryptedCookie,
:secret => 'sk_test_bwDx3bL8ONyYLjuz12VSCOv1' # Actually use something secret here!

get '/' do
    status 200
    return "Great, your backend is set up. Now you can configure the Stripe example apps to point here."
end

post '/ephemeral_keys' do
    authenticate!
    begin
        key = Stripe::EphemeralKey.create(
                                          {customer: @customer.id},
                                          {stripe_version: params["api_version"]}
                                          )
                                          rescue Stripe::StripeError => e
                                          status 402
                                          return "Error creating ephemeral key: #{e.message}"
    end
    
    status 200
    key.to_json
end

token = params[:stripeToken]

customer = Stripe::customer.create(
                                   :email => "paying.user@example.com",
                                   :source => token,
                                   )

post '/charge' do
    authenticate!
    # Get the credit card details submitted by the form
    source = params[:source]
    
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
        charge = Stripe::Charge.create(
                                       :amount => params[:amount], # this number should be in cents
                                       :currency => "usd",
                                       :customer => @customer.id,
                                       :source => token,
                                       :description => "Example Charge",
                                       )
                                       rescue Stripe::StripeError => e
                                       status 402
                                       return "Error creating charge: #{e.message}"
    end
    
    status 200
    return "Charge successfully created"
end

charge = Stripe::Charge.create(
                               :amount => 1500, # $15.00 this time
                               :currency => "usd",
                               :customer => customer_id, # Previously stored, then retrieved
                               )

def authenticate!
    # This code simulates "loading the Stripe customer for your current session".
    # Your own logic will likely look very different.
    return @customer if @customer
    if session.has_key?(:customer_id)
        customer_id = session[:customer_id]
        begin
            @customer = Stripe::Customer.retrieve(customer_id)
            rescue Stripe::InvalidRequestError
        end
        else
        begin
            @customer = Stripe::Customer.create(:description => "mobile SDK example customer")
            rescue Stripe::InvalidRequestError
        end
        session[:customer_id] = @customer.id
    end
    @customer
end


# This endpoint responds to webhooks sent by Stripe. To use it, you'll need
# to add its URL (https://{your-app-name}.herokuapp.com/stripe-webhook)
# in the webhook settings section of the Dashboard.
# https://dashboard.stripe.com/account/webhooks
post '/stripe-webhook' do
    json = JSON.parse(request.body.read)
    
    # Retrieving the event from Stripe guarantees its authenticity
    event = Stripe::Event.retrieve(json["id"])
    source = event.data.object
    
    # For sources that require additional user action from your customer
    # (e.g. authorizing the payment with their bank), you should use webhooks
    # to create a charge after the source becomes chargeable.
    # For more information, see https://stripe.com/docs/sources#best-practices
    WEBHOOK_CHARGE_CREATION_TYPES = ['bancontact', 'giropay', 'ideal', 'sofort', 'three_d_secure']
    if event.type == 'source.chargeable' && WEBHOOK_CHARGE_CREATION_TYPES.include?(source.type)
        begin
            charge = Stripe::Charge.create(
                                           :amount => source.amount,
                                           :currency => source.currency,
                                           :source => source.id,
                                           :customer => source.metadata["customer"],
                                           :description => "Example Charge"
                                           )
                                           rescue Stripe::StripeError => e
                                           p "Error creating charge: #{e.message}"
                                           return
        end
        # After successfully creating a charge, you should complete your customer's
        # order and notify them that their order has been fulfilled (e.g. by sending
        # an email). When creating the source in your app, consider storing any order
        # information (e.g. order number) as metadata so that you can retrieve it
        # here and use it to complete your customer's purchase.
    end
    status 200
end