# Manages Client's Billing info.
class BillingsController < ApplicationController
  def create
    search_history = SearchHistory.find(params[:search_history_id])
    billing = current_user.build_billing(billing_params)
    if billing.save
      if params[:payment_steps].present?
        redirect_to client_payment_card_path(search_history_id: search_history.id, payment_steps: true)
      else
        redirect_to client_dashboard_path
      end
    else
      render status: 500
    end
  end

  def update
    if current_user.billing
      current_user.billing.update_attributes(billing_params)
    else
      billing = current_user.build_billing(billing_params)
      billing.save
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    billing = current_user.billings.find(params[:billing_id])
    billing.destroy
  end

  private

  def in_payment_steps
    if contact.save && current_user.type == 'Client' && params[:controller] == 'clients_informations'
      true
    else
      false
    end
  end

  def billing_params
    params.require(:billing).permit(:legal_name, :street, :city, :state, :zip, :country)
  end
end
