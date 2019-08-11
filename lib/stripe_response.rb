# StripeReponse for stub
module StripeResponse
  def stripe_charge_create
    RecursiveOpenStruct.new(
      "id": 'ch_1BZ4lbL1bob9dOrWHpzQ44Fa',
      "object": 'charge',
      "amount": 100,
      "amount_refunded": 0,
      "application": nil,
      "application_fee": nil,
      "balance_transaction": 'txn_1BZ4lbL1bob9dOrWM9RYUSqT',
      "captured": false,
      "created": 1_513_288_883,
      "currency": 'cad',
      "customer": nil,
      "description": 'My First Test Charge (created for API docs)',
      "destination": nil,
      "dispute": nil,
      "failure_code": nil,
      "failure_message": nil,
      "fraud_details": {
      },
      "invoice": nil,
      "livemode": false,
      "metadata": {
      },
      "on_behalf_of": nil,
      "order": nil,
      "outcome": nil,
      "paid": true,
      "receipt_email": nil,
      "receipt_number": nil,
      "refunded": false,
      "refunds": {
        "object": 'list',
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": '/v1/charges/ch_1BZ4lbL1bob9dOrWHpzQ44Fa/refunds'
      },
      "review": nil,
      "shipping": nil,
      "source": {
        "id": 'card_1BYcRTL1bob9dOrWEGuevbU2',
        "object": 'card',
        "address_city": 'Toronto',
        "address_country": nil,
        "address_line1": '12 Jam',
        "address_line1_check": 'pass',
        "address_line2": nil,
        "address_state": 'ON',
        "address_zip": '22442',
        "address_zip_check": 'pass',
        "brand": 'Visa',
        "country": 'US',
        "customer": 'cus_BwVSd0dSpt0VjD',
        "cvc_check": 'pass',
        "dynamic_last4": nil,
        "exp_month": 2,
        "exp_year": 2042,
        "fingerprint": 'DFbHxdbzsfHx4Xfs',
        "funding": 'credit',
        "last4": '4242',
        "metadata": {
        },
        "name": 'Tomato',
        "tokenization_method": nil
      },
      "source_transfer": nil,
      "statement_descriptor": nil,
      "status": 'succeeded',
      "transfer_group": nil
    )
  end

  def stripe_customer_create
    RecursiveOpenStruct.new(
      "id": 'cus_BwyjTN4rjWJQLJ',
      "object": 'customer',
      "account_balance": 0,
      "created": 1_513_288_883,
      "currency": 'cad',
      "default_source": nil,
      "delinquent": false,
      "description": nil,
      "discount": nil,
      "email": nil,
      "livemode": false,
      "metadata": {
      },
      "shipping": nil,
      "sources": {
        "object": 'list',
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": '/v1/customers/cus_BwyjTN4rjWJQLJ/sources'
      },
      "subscriptions": {
        "object": 'list',
        "data": []
      },
      "has_more": false,
      "total_count": 0,
      "url": '/v1/customers/cus_BwyjTN4rjWJQLJ/subscriptions'
    )
  end

  def stripe_customer_retrieve
    RecursiveOpenStruct.new(
      "id": 'cus_BwyjTN4rjWJQLJ',
      "object": 'customer',
      "account_balance": 0,
      "created": 1_513_288_883,
      "currency": 'cad',
      "default_source": nil,
      "delinquent": false,
      "description": nil,
      "discount": nil,
      "email": nil,
      "livemode": false,
      "metadata": {},
      "shipping": nil,
      "sources": {
        "object": 'list',
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": '/v1/customers/cus_BwyjTN4rjWJQLJ/sources'
      },
      "subscriptions": {
        "object": 'list',
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": '/v1/customers/cus_BwyjTN4rjWJQLJ/subscriptions'
      }
    )
  end

  def stripe_customer_retrieve_with(customer_id)
    RecursiveOpenStruct.new(
      "id": customer_id.to_s,
      "object": 'customer',
      "account_balance": 0,
      "created": 1_513_288_883,
      "currency": 'cad',
      "default_source": nil,
      "delinquent": false,
      "description": nil,
      "discount": nil,
      "email": nil,
      "livemode": false,
      "metadata": {},
      "shipping": nil,
      "sources": {
        "object": 'list',
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": '/v1/customers/cus_BwyjTN4rjWJQLJ/sources'
      },
      "subscriptions": {
        "object": 'list',
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": '/v1/customers/cus_BwyjTN4rjWJQLJ/subscriptions'
      }
    )
  end
end
