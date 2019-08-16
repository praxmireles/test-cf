# handle Payout for Expert
class PayoutsController < ApplicationController
  include Marketplaceable

  def create
    if current_user.payout_method == 'Paypal'
      paypal_payout(current_user)
    else
      transfer_fund(current_user)
    end
    redirect_to balance_expert_path
  end

  def edit
    # Change External Account
  end

  def destroy
    current_user.update_attributes(stripe_account_id: nil)
    redirect_to balance_expert_path
  end
end
