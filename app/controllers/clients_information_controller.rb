# Handle Steps for gathering the user payment information during the onboarding
class ClientsInformationController < ApplicationController
  def billing
    @billing = current_user.billing || current_user.build_billing
  end

  def payment
    search_history = SearchHistory.find(params[:search_history_id])
    @service_fees = Service.find_by_type(search_history.service).price
  end

  def contacts
    @contact_information = current_user.build_contact_information
  end

  def update_billing
    if @billing.save
      redirect_to client_update_payment_path
    else
      redirect_back
    end
  end

  def update_payment
    if @card.save
      redirect_to client_update_contact_information
    else
      redirect_back
    end
  end

  def update_contact_information
    if @contact_information.save
      redirect_to client_dashboard_path
    else
      redirect_back
    end
  end
end
