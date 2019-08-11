# frozen_string_literal: true

# Manages pages and actions for invoices
class InvoicesController < ApplicationController
  def show
    current_user.invoices.find(params[:invoice_id])
  end

  def index
    current_user.invoices.order('date DESC').all
  end
end
