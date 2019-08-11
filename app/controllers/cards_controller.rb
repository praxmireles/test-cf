# frozen_string_literal: true

# Manages pages and action related to the client's credit cards
class CardsController < ApplicationController
  # List All Cards
  def index
    @cards = Card.all
  end

  # Add new Card
  def create
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    stripe_card = customer.sources.create(source: params[:stripeToken])

    card = current_user.cards.new(
      stripe_card_uid: stripe_card.id,
      stripe_card_brand: stripe_card.brand,
      stripe_card_last4: stripe_card.last4,
      stripe_card_exp_month: stripe_card.exp_month,
      stripe_card_exp_year: strip_card.exp_year
    )

    if card.save
      render json: { card: card }, status: 200
    else
      render status: 500
    end
  end

  # Remove Card
  def destroy
    card = current_user.cards.find(params[:card_id])
    card.destroy
  end
end
