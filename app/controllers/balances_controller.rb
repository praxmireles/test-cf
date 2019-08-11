# Balance showing the amount that we own the user for a payout or withdrawal
class BalancesController < ApplicationController
  def index
    @balance = current_user.balance
  end

  def show
    # Get the balance from Stripe
    # balance = Stripe::Balance.retrieve() if current_user.stripe_account_id.present?
  end
end
