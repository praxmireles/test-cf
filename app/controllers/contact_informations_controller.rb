# User's Contact Information
class ContactInformationsController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def create
    if current_user.contact_information.nil?
      contact = current_user.build_contact_information(contact_params)
    else
      contact = current_user.contact_information
      contact.primary_phone = contact_params[:primary_phone]
      contact.primary_mobile = contact_params[:primary_mobile]
    end
    contact.save
    if contact.id && current_user.type == 'Expert'
      redirect_to resume_path
    elsif in_payment_steps(contact)
      redirect_to client_dashboard_path
    else
      redirect_to client_dashboard_path
    end
  end
  # rubocop:enable Metrics/AbcSize

  def update
    current_user.contact_information.update_attribute(contact_params)
  end

  def destroy
    current_user.contact_information.destroy
  end

  private

  def in_payment_steps(contact)
    if contact.save && current_user.type == 'Client' && params[:controller] == 'contact_informations'
      true
    else
      false
    end
  end

  def contact_params
    params.require(:contact_information).permit(
      :primary_phone, :secondary_phone, :primary_mobile, :secondary_mobile,
      :mobile_contact_time, :phone_contact_time
    )
  end
end
